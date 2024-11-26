import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/option.{type Option, None, Some}
import gleam/result
import sqlight.{type Connection, type Error}
import widgets/helper/dynamic_helper

pub type StaticFile {
  StaticFile(id: Int, path: String, file_id: Int, created_at: Int)
}

pub type Statements {
  Statements(
    get: fn(Int) -> Result(Option(StaticFile), Error),
    get_by_path: fn(String) -> Result(Option(StaticFile), Error),
    insert_new: fn(String, Int, Int) -> Result(Int, Error),
    delete: fn(Int) -> Result(Nil, Error),
    update: fn(StaticFile) -> Result(StaticFile, Error),
  )
}

pub fn decoder() -> fn(Dynamic) -> Result(StaticFile, List(DecodeError)) {
  dynamic.tuple4(dynamic.int, dynamic.string, dynamic.int, dynamic.int)
  |> dynamic_helper.map(fn(value) {
    let #(id, path, file_id, created_at) = value
    Ok(StaticFile(id:, path:, file_id:, created_at:))
  })
}

pub fn statements(db: Connection) -> Result(Statements, Error) {
  use get <- result.try(get(db))
  use get_by_path <- result.try(get_by_path(db))
  use insert_new <- result.try(insert_new(db))
  use delete <- result.try(delete(db))
  use update <- result.try(update(db))

  Ok(Statements(get:, get_by_path:, insert_new:, delete:, update:))
}

fn get(
  db: Connection,
) -> Result(fn(Int) -> Result(Option(StaticFile), Error), Error) {
  fn(id: Int) -> Result(Option(StaticFile), Error) {
    sqlight.query(
      "
SELECT
  \"id\",
  \"path\",
  \"file_metadata_id\",
  \"created_at\"
FROM
  \"static_file\"
WHERE
  \"id\" = ?
  AND
  \"deleted\" = 0;
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

fn get_by_path(
  db: Connection,
) -> Result(fn(String) -> Result(Option(StaticFile), Error), Error) {
  fn(path: String) -> Result(Option(StaticFile), Error) {
    sqlight.query(
      "
SELECT
  \"id\",
  \"path\",
  \"file_metadata_id\",
  \"created_at\"
FROM
  \"static_file\"
WHERE
  \"deleted\" = 0
  AND
  \"path\" = ?
ORDER BY
  \"created_at\" DESC;
        ",
      db,
      [sqlight.text(path)],
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

fn insert_new(
  db: Connection,
) -> Result(fn(String, Int, Int) -> Result(Int, Error), Error) {
  fn(path: String, file_id: Int, now: Int) -> Result(Int, Error) {
    sqlight.query(
      "
INSERT INTO
  \"static_file\"
  (\"path\", \"file_metadata_id\", \"created_at\", \"deleted\")
VALUES
  (?, ?, ?, 0)
RETURNING
  \"id\",
  \"path\",
  \"file_metadata_id\",
  \"created_at\";
        ",
      db,
      [sqlight.text(path), sqlight.int(file_id), sqlight.int(now)],
      dynamic.element(0, dynamic.int),
    )
    |> result.map(fn(values) {
      case values {
        [] ->
          Error(sqlight.SqlightError(
            sqlight.Notfound,
            "Could not find inserted file",
            -1,
          ))
        [value, ..] -> Ok(value)
      }
    })
    |> result.flatten
  }
  |> Ok
}

fn delete(db: Connection) -> Result(fn(Int) -> Result(Nil, Error), Error) {
  fn(id: Int) -> Result(Nil, Error) {
    sqlight.query(
      "
UPDATE
  \"static_file\"
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

fn update(
  db: Connection,
) -> Result(fn(StaticFile) -> Result(StaticFile, Error), Error) {
  fn(file: StaticFile) -> Result(StaticFile, Error) {
    sqlight.query(
      "
UPDATE
  \"static_file\"
SET
  \"path\" = ?,
  \"file_metadata_id\" = ?,
  \"created_at\" = ?
WHERE
  \"id\" = ?
  AND
  \"deleted\" = 0
RETURNING
  \"id\",
  \"path\",
  \"file_metadata_id\",
  \"created_at\";
        ",
      db,
      [
        sqlight.text(file.path),
        sqlight.int(file.file_id),
        sqlight.int(file.created_at),
        sqlight.int(file.id),
      ],
      decoder(),
    )
    |> result.map(fn(values) {
      case values {
        [] ->
          Error(sqlight.SqlightError(
            sqlight.Notfound,
            "Could not find updated file",
            -1,
          ))
        [value, ..] -> Ok(value)
      }
    })
    |> result.flatten
  }
  |> Ok
}
