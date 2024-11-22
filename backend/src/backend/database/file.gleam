import gleam/bit_array
import gleam/crypto
import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/int
import gleam/option.{type Option, None, Some}
import gleam/result
import sqlight.{type Connection, type Error}

pub type File {
  File(
    id: Int,
    key: BitArray,
    name: String,
    content_type: Option(String),
    created_at: Int,
    updated_at: Int,
    hash: BitArray,
    size: Int,
  )
}

pub type Statements {
  Statements(
    get: fn(Int) -> Result(Option(File), Error),
    get_by_key: fn(BitArray) -> Result(Option(File), Error),
    delete: fn(Int) -> Result(Nil, Error),
    insert_new: fn(String, Option(String), BitArray, Int) -> Result(File, Error),
    update: fn(File, Option(BitArray), Int) -> Result(File, Error),
    data: fn(File) -> Result(BitArray, Error),
  )
}

pub fn decoder() -> fn(Dynamic) -> Result(File, List(DecodeError)) {
  dynamic.decode8(
    File,
    dynamic.element(0, dynamic.int),
    dynamic.element(1, dynamic.bit_array),
    dynamic.element(2, dynamic.string),
    dynamic.element(3, dynamic.optional(dynamic.string)),
    dynamic.element(4, dynamic.int),
    dynamic.element(5, dynamic.int),
    dynamic.element(6, dynamic.bit_array),
    dynamic.element(7, dynamic.int),
  )
}

pub fn statements(db: Connection) -> Result(Statements, Error) {
  use get <- result.try(get(db))
  use get_by_key <- result.try(get_by_key(db))
  use delete <- result.try(delete(db))
  use insert_file_data <- result.try(insert_file_data(db))
  use insert_new <- result.try(insert_new(db, insert_file_data, get))
  use update <- result.try(update(db, insert_file_data, get))
  use data <- result.try(data(db))

  Ok(Statements(get:, get_by_key:, delete:, insert_new:, update:, data:))
}

fn get(db: Connection) -> Result(fn(Int) -> Result(Option(File), Error), Error) {
  fn(id: Int) -> Result(Option(File), Error) {
    sqlight.query(
      "
SELECT
  \"m\".\"id\",
  \"m\".\"key\",
  \"m\".\"name\",
  \"m\".\"content_type\",
  \"m\".\"created_at\",
  \"m\".\"updated_at\",
  \"f\".\"hash\",
  \"f\".\"size\"
FROM
  \"file\" AS \"f\"
INNER JOIN
  \"file_metadata\" AS \"m\"
ON
  \"m\".\"file_id\" = \"f\".\"id\"
WHERE
  \"m\".\"id\" = ?
  AND
  \"m\".\"deleted\" = 0;
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
  |> Ok
}

fn get_by_key(
  db: Connection,
) -> Result(fn(BitArray) -> Result(Option(File), Error), Error) {
  fn(key: BitArray) -> Result(Option(File), Error) {
    sqlight.query(
      "
SELECT
  \"m\".\"id\",
  \"m\".\"key\",
  \"m\".\"name\",
  \"m\".\"content_type\",
  \"m\".\"created_at\",
  \"m\".\"updated_at\",
  \"f\".\"hash\",
  \"f\".\"size\"
FROM
  \"file\" AS \"f\"
INNER JOIN
  \"file_metadata\" AS \"m\"
ON
  \"m\".\"file_id\" = \"f\".\"id\"
WHERE
  \"m\".\"key\" = ?
  AND
  \"m\".\"deleted\" = 0;
        ",
      db,
      [sqlight.blob(key)],
      decoder(),
    )
    |> result.map(fn(values) {
      case values {
        [] -> None
        [value, ..] -> Some(value)
      }
    })
  }
  |> Ok
}

fn delete(db: Connection) -> Result(fn(Int) -> Result(Nil, Error), Error) {
  fn(id: Int) -> Result(Nil, Error) {
    sqlight.query(
      "
UPDATE
  \"file\"
SET
  \"deleted\" = 1
WHERE
  \"id\" = ?;
    ",
      db,
      [sqlight.int(id)],
      dynamic.dynamic,
    )
    |> result.map(fn(_) { Nil })
  }
  |> Ok
}

fn insert_file_data(
  db: Connection,
) -> Result(fn(BitArray) -> Result(Int, Error), Error) {
  fn(data: BitArray) -> Result(Int, Error) {
    let size = bit_array.byte_size(data)
    let hash = crypto.hash(crypto.Sha512, data)

    use file_id <- result.try(
      sqlight.query(
        "
SELECT
  \"id\"
FROM
  \"file\"
WHERE
  \"hash\" = ?;
      ",
        db,
        [sqlight.blob(hash)],
        dynamic.element(0, dynamic.int),
      )
      |> result.map(fn(values) {
        case values {
          [] -> None
          [value, ..] -> Some(value)
        }
      }),
    )

    case file_id {
      Some(file_id) -> Ok(file_id)
      None -> {
        case
          sqlight.query(
            "
INSERT INTO
  \"file\"
  (\"hash\", \"data\", \"size\")
VALUES
  (?, ?, ?)
RETURNING
  \"id\";
        ",
            db,
            [sqlight.blob(hash), sqlight.blob(data), sqlight.int(size)],
            dynamic.element(0, dynamic.int),
          )
        {
          Ok([]) ->
            Error(sqlight.SqlightError(
              sqlight.Notfound,
              "Could not find inserted file",
              -1,
            ))
          Ok([id, ..]) -> Ok(id)
          Error(error) -> Error(error)
        }
      }
    }
  }
  |> Ok
}

fn insert_new(
  db: Connection,
  insert_file_data: fn(BitArray) -> Result(Int, Error),
  get: fn(Int) -> Result(Option(File), Error),
) -> Result(
  fn(String, Option(String), BitArray, Int) -> Result(File, Error),
  Error,
) {
  fn(name: String, content_type: Option(String), data: BitArray, now: Int) -> Result(
    File,
    Error,
  ) {
    use file_id <- result.try(insert_file_data(data))

    let key =
      crypto.strong_random_bytes(224 / 8)
      |> bit_array.append(<<int.to_string(file_id):utf8>>)
      |> bit_array.append(<<int.to_string(now):utf8>>)
      |> crypto.hash(crypto.Sha224, _)

    use id <- result.try(case
      sqlight.query(
        "
INSERT INTO
  \"file_metadata\"
  (\"file_id\", \"key\", \"name\", \"content_type\", \"created_at\", \"updated_at\", \"deleted\")
VALUES
  (?, ?, ?, ?, ?, ?, 0)
RETURNING
  \"id\";
        ",
        db,
        [
          sqlight.int(file_id),
          sqlight.blob(key),
          sqlight.text(name),
          sqlight.nullable(sqlight.text, content_type),
          sqlight.int(now),
          sqlight.int(now),
        ],
        dynamic.element(0, dynamic.int),
      )
    {
      Ok([]) ->
        Error(sqlight.SqlightError(
          sqlight.Notfound,
          "Could not find inserted file metadata",
          -1,
        ))
      Ok([id, ..]) -> Ok(id)
      Error(error) -> Error(error)
    })

    case get(id) {
      Ok(Some(file)) -> Ok(file)
      Ok(None) ->
        Error(sqlight.SqlightError(sqlight.Notfound, "Could not find file", -1))
      Error(error) -> Error(error)
    }
  }
  |> Ok
}

fn update(
  db: Connection,
  insert_file_data: fn(BitArray) -> Result(Int, Error),
  get: fn(Int) -> Result(Option(File), Error),
) -> Result(fn(File, Option(BitArray), Int) -> Result(File, Error), Error) {
  fn(file: File, data: Option(BitArray), now: Int) -> Result(File, Error) {
    use file_id <- result.try(case data {
      None ->
        case
          sqlight.query(
            "
SELECT
  \"f\".\"id\"
FROM
  \"file_metadata\" AS \"m\"
INNER JOIN
  \"file\" AS \"f\"
ON
  \"m\".\"file_id\" = \"f\".\"id\"
WHERE
  \"m\".\"id\" = ?;
        ",
            db,
            [sqlight.int(file.id)],
            dynamic.element(0, dynamic.int),
          )
        {
          Ok([]) ->
            Error(sqlight.SqlightError(
              sqlight.Notfound,
              "Could not find existing file",
              -1,
            ))
          Ok([id, ..]) -> Ok(id)
          Error(error) -> Error(error)
        }
      Some(data) -> insert_file_data(data)
    })

    use _ <- result.try(sqlight.query(
      "
UPDATE
  \"file\"
SET
  \"file_id\" = ?,
  \"key\" = ?,
  \"name\" = ?,
  \"content_type\" = ?,
  \"created_at\" = ?,
  \"updated_at\" = ?
WHERE
  \"id\" = ?
  AND
  \"deleted\" = 0;
    ",
      db,
      [
        sqlight.int(file_id),
        sqlight.blob(file.key),
        sqlight.text(file.name),
        sqlight.nullable(sqlight.text, file.content_type),
        sqlight.int(file.created_at),
        sqlight.int(now),
        sqlight.int(file.id),
      ],
      dynamic.dynamic,
    ))

    case get(file.id) {
      Ok(Some(file)) -> Ok(file)
      Ok(None) ->
        Error(sqlight.SqlightError(
          sqlight.Notfound,
          "Could not find updated file",
          -1,
        ))
      Error(error) -> Error(error)
    }
  }
  |> Ok
}

fn data(db: Connection) -> Result(fn(File) -> Result(BitArray, Error), Error) {
  fn(file: File) -> Result(BitArray, Error) {
    case
      sqlight.query(
        "
SELECT
  \"f\".\"data\"
FROM
  \"file_metadata\" AS \"m\"
INNER JOIN
  \"file\" AS \"f\"
ON
  \"m\".\"file_id\" = \"f\".\"id\"
WHERE
  \"m\".\"id\" = ?
  AND
  \"m\".\"deleted\" = 0
LIMIT 1;
        ",
        db,
        [sqlight.int(file.id)],
        dynamic.element(0, dynamic.bit_array),
      )
    {
      Ok([]) ->
        Error(sqlight.SqlightError(
          sqlight.Notfound,
          "Could not find existing file",
          -1,
        ))
      Ok([data, ..]) -> Ok(data)
      Error(error) -> Error(error)
    }
  }
  |> Ok
}
