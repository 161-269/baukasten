import aragorn2
import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string
import sqlight.{type Connection, type Error}
import widgets/helper/dynamic_helper

pub type User {
  User(id: Int, username: String, email: String, password: BitArray)
}

pub fn decoder() -> fn(Dynamic) -> Result(User, List(DecodeError)) {
  dynamic.tuple4(dynamic.int, dynamic.string, dynamic.string, dynamic.bit_array)
  |> dynamic_helper.map(fn(value) {
    let #(id, username, email, password) = value
    Ok(User(id:, username:, email:, password:))
  })
}

pub fn get(db: Connection, id: Int) -> Result(Option(User), Error) {
  sqlight.query(
    "
SELECT
  \"id\",
  \"username\",
  \"email\",
  \"password\"
FROM
  \"user\"
WHERE
  \"id\" = ?;
    ",
    db,
    [sqlight.int(id)],
    decoder(),
  )
  |> result.map(fn(values) {
    case values {
      [] -> None
      [value, ..] -> Some(value)
    }
  })
}

pub fn search(
  db: Connection,
  username_or_email: String,
) -> Result(List(User), Error) {
  sqlight.query(
    "
SELECT
  \"id\",
  \"username\",
  \"email\",
  \"password\"
FROM
  \"user\"
WHERE
  (
    \"username\" = ?
    OR
    \"email\" = ?
  );
    ",
    db,
    [sqlight.text(username_or_email), sqlight.text(username_or_email)],
    decoder(),
  )
}

fn hasher() -> aragorn2.Hasher {
  aragorn2.hasher()
  |> aragorn2.with_parallelism(4)
  |> aragorn2.with_hash_length(64)
  |> aragorn2.with_memory_cost(64 * 1024)
  |> aragorn2.with_time_cost(6)
}

fn hash_password(password: String) -> Result(BitArray, Error) {
  use _ <- result.try(case string.length(password) < 16 {
    True ->
      Error(sqlight.SqlightError(sqlight.GenericError, "Password too short", -1))
    False -> Ok(Nil)
  })

  use password <- result.try(
    aragorn2.hash_password(hasher(), <<password:utf8>>)
    |> result.map_error(fn(_) {
      sqlight.SqlightError(sqlight.GenericError, "Could not hash password", -1)
    }),
  )

  Ok(<<password:utf8>>)
}

pub fn insert_new(
  db: Connection,
  username: String,
  email: String,
  password: String,
) -> Result(User, Error) {
  use password <- result.try(hash_password(password))

  use users <- result.try(sqlight.query(
    "
INSERT INTO
  \"user\"
  (\"username\", \"email\", \"password\")
VALUES
  (?, ?, ?)
RETURNING
  \"id\",
  \"username\",
  \"email\",
  \"password\";
      ",
    db,
    [sqlight.text(username), sqlight.text(email), sqlight.blob(password)],
    decoder(),
  ))

  case users {
    [] ->
      Error(sqlight.SqlightError(
        sqlight.Notfound,
        "Could not find inserted user",
        -1,
      ))
    [user, ..] -> Ok(user)
  }
}

pub fn sarch_and_verify(
  db: Connection,
  username_or_email: String,
  password: String,
) -> Result(User, Error) {
  use users <- result.try(search(db, username_or_email))
  case users {
    [user] -> {
      use _ <- result.try(
        aragorn2.verify_password(hasher(), <<password:utf8>>, user.password)
        |> result.map_error(fn(_) {
          sqlight.SqlightError(
            sqlight.GenericError,
            "Could not verify password",
            -1,
          )
        }),
      )

      Ok(user)
    }
    _ -> {
      // Waste some time to prevent brute force and timing attacks
      let _ = aragorn2.hash_password(hasher(), <<password:utf8>>)

      Error(sqlight.SqlightError(sqlight.Notfound, "Could not find user", -1))
    }
  }
}

pub fn update(
  db: Connection,
  user: User,
  password: Option(String),
) -> Result(User, Error) {
  use password <- result.try(case option.map(password, hash_password) {
    None -> Ok(None)
    Some(password) -> {
      result.map(password, Some)
    }
  })

  let user = case password {
    None -> user
    Some(password) -> User(..user, password:)
  }

  use user <- result.try(sqlight.query(
    "
UPDATE
  \"user\"
SET
  \"username\" = ?,
  \"email\" = ?,
  \"password\" = ?
WHERE
  \"id\" = ?;
RETURNING
  \"id\",
  \"username\",
  \"email\",
  \"password\";
    ",
    db,
    [
      sqlight.text(user.username),
      sqlight.text(user.email),
      sqlight.blob(user.password),
      sqlight.int(user.id),
    ],
    decoder(),
  ))

  case user {
    [] ->
      Error(sqlight.SqlightError(sqlight.Notfound, "Could not find user", -1))
    [user, ..] -> Ok(user)
  }
}

pub fn user_count(db: Connection) -> Result(Int, Error) {
  let count =
    sqlight.query(
      "
SELECT
  COUNT(*)
FROM
  \"user\";
    ",
      db,
      [],
      dynamic.element(0, dynamic.int),
    )

  case count {
    Ok(count) ->
      case count {
        [count] -> Ok(count)
        _ ->
          Error(sqlight.SqlightError(
            sqlight.GenericError,
            "Could not get user count",
            -1,
          ))
      }
    Error(error) -> Error(error)
  }
}
