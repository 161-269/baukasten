import aragorn2
import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string
import sqlight.{type Connection, type Error}
import widgets/helper/dynamic_helper

pub type User {
  User(
    id: Int,
    username: String,
    email: String,
    password: BitArray,
    read_changelog_version: Option(String),
  )
}

pub type Statements {
  Statements(
    get: fn(Int) -> Result(Option(User), Error),
    search: fn(String) -> Result(Option(User), Error),
    insert_new: fn(String, String, String) -> Result(User, Error),
    search_and_verify: fn(String, String) -> Result(User, Error),
    update: fn(User, Option(String)) -> Result(User, Error),
    count: fn() -> Result(Int, Error),
  )
}

pub fn decoder() -> fn(Dynamic) -> Result(User, List(DecodeError)) {
  dynamic.tuple5(
    dynamic.int,
    dynamic.string,
    dynamic.string,
    dynamic.bit_array,
    dynamic.optional(dynamic.string),
  )
  |> dynamic_helper.map(fn(value) {
    let #(id, username, email, password, read_changelog_version) = value
    Ok(User(id:, username:, email:, password:, read_changelog_version:))
  })
}

pub fn statements(db: Connection) -> Result(Statements, Error) {
  use get <- result.try(get(db))
  use search <- result.try(search(db))
  use insert_new <- result.try(insert_new(db))
  use search_and_verify <- result.try(search_and_verify(search))
  use update <- result.try(update(db))
  use count <- result.try(count(db))

  Ok(Statements(get:, search:, insert_new:, search_and_verify:, update:, count:))
}

fn get(db: Connection) -> Result(fn(Int) -> Result(Option(User), Error), Error) {
  use select <- result.try(sqlight.prepare(
    "
SELECT
  \"id\",
  \"username\",
  \"email\",
  \"password\",
  \"read_changelog_version\"
FROM
  \"user\"
WHERE
  \"id\" = ?;
    ",
    db,
    decoder(),
  ))
  fn(id: Int) -> Result(Option(User), Error) {
    sqlight.query_prepared(select, [sqlight.int(id)])
    |> result.map(fn(values) {
      case values {
        [] -> None
        [value, ..] -> Some(value)
      }
    })
  }
  |> Ok
}

fn search(
  db: Connection,
) -> Result(fn(String) -> Result(Option(User), Error), Error) {
  use select <- result.try(sqlight.prepare(
    "
SELECT
  \"id\",
  \"username\",
  \"email\",
  \"password\",
  \"read_changelog_version\"
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
    decoder(),
  ))
  fn(username_or_email: String) -> Result(Option(User), Error) {
    case
      sqlight.query_prepared(select, [
        sqlight.text(username_or_email),
        sqlight.text(username_or_email),
      ])
    {
      Ok([]) -> Ok(None)
      Ok([user, ..]) -> Ok(Some(user))
      Error(error) -> Error(error)
    }
  }
  |> Ok
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
      Error(sqlight.SqlightError(
        sqlight.GenericError,
        "Password too short (minimum 16 characters)",
        -1,
      ))
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

fn insert_new(
  db: Connection,
) -> Result(fn(String, String, String) -> Result(User, Error), Error) {
  use insert <- result.try(sqlight.prepare(
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
  \"password\",
  \"read_changelog_version\";
      ",
    db,
    decoder(),
  ))
  fn(username: String, email: String, password: String) -> Result(User, Error) {
    use password <- result.try(hash_password(password))

    use users <- result.try(
      sqlight.query_prepared(insert, [
        sqlight.text(username),
        sqlight.text(email),
        sqlight.blob(password),
      ]),
    )

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
  |> Ok
}

fn search_and_verify(
  search: fn(String) -> Result(Option(User), Error),
) -> Result(fn(String, String) -> Result(User, Error), Error) {
  fn(username_or_email: String, password: String) -> Result(User, Error) {
    use user <- result.try(search(username_or_email))
    case user {
      Some(user) -> {
        case
          aragorn2.verify_password(hasher(), <<password:utf8>>, user.password)
        {
          Ok(_) -> Ok(user)
          Error(_) ->
            Error(sqlight.SqlightError(
              sqlight.GenericError,
              "Could not verify password",
              -1,
            ))
        }
      }
      None -> {
        // Waste some time to prevent brute force and timing attacks
        let _ = aragorn2.hash_password(hasher(), <<password:utf8>>)

        Error(sqlight.SqlightError(sqlight.Notfound, "Could not find user", -1))
      }
    }
  }
  |> Ok
}

fn update(
  db: Connection,
) -> Result(fn(User, Option(String)) -> Result(User, Error), Error) {
  use update <- result.try(sqlight.prepare(
    "
UPDATE
  \"user\"
SET
  \"username\" = ?,
  \"email\" = ?,
  \"password\" = ?,
  \"read_changelog_version\" = ?
WHERE
  \"id\" = ?
RETURNING
  \"id\",
  \"username\",
  \"email\",
  \"password\",
  \"read_changelog_version\";
    ",
    db,
    decoder(),
  ))
  fn(user: User, password: Option(String)) -> Result(User, Error) {
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

    use user <- result.try(
      sqlight.query_prepared(update, [
        sqlight.text(user.username),
        sqlight.text(user.email),
        sqlight.blob(user.password),
        sqlight.nullable(sqlight.text, user.read_changelog_version),
        sqlight.int(user.id),
      ]),
    )

    case user {
      [] ->
        Error(sqlight.SqlightError(
          sqlight.Notfound,
          "Could not find updated user",
          -1,
        ))
      [user, ..] -> Ok(user)
    }
  }
  |> Ok
}

fn count(db: Connection) -> Result(fn() -> Result(Int, Error), Error) {
  use select <- result.try(sqlight.prepare(
    "
SELECT
  COUNT(*)
FROM
  \"user\";
    ",
    db,
    dynamic.element(0, dynamic.int),
  ))
  fn() -> Result(Int, Error) {
    let count = sqlight.query_prepared(select, [])

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
  |> Ok
}
