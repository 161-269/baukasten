import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/option.{type Option, None, Some}
import gleam/result
import sqlight.{type Connection, type Error}
import widgets/helper/dynamic_helper

pub type Configuration {
  Configuration(key: String, value: String, created_at: Int)
}

pub type Statements {
  Statements(
    get: fn(String) -> Result(Option(Configuration), Error),
    set: fn(String, String, Int) -> Result(Nil, Error),
  )
}

pub fn decoder() -> fn(Dynamic) -> Result(Configuration, List(DecodeError)) {
  dynamic.tuple3(dynamic.string, dynamic.string, dynamic.int)
  |> dynamic_helper.map(fn(value) {
    let #(key, value, created_at) = value
    Ok(Configuration(key:, value:, created_at:))
  })
}

pub fn statements(db: Connection) -> Result(Statements, Error) {
  use get <- result.try(get(db))
  use set <- result.try(set(db))

  Ok(Statements(get:, set:))
}

fn get(
  db: Connection,
) -> Result(fn(String) -> Result(Option(Configuration), Error), Error) {
  fn(key: String) -> Result(Option(Configuration), Error) {
    sqlight.query(
      "
SELECT
  \"key\",
  \"value\",
  \"created_at\"
FROM
  \"configuration\"
WHERE
  \"key\" = ?
ORDER BY
  \"created_at\" DESC
LIMIT 1;
    ",
      db,
      [sqlight.text(key)],
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

fn set(
  db: Connection,
) -> Result(fn(String, String, Int) -> Result(Nil, Error), Error) {
  fn(key: String, value: String, now: Int) {
    sqlight.query(
      "
INSERT INTO
  \"configuration\"
  (\"key\", \"value\", \"created_at\")
VALUES
  (?, ?, ?);
    ",
      db,
      [sqlight.text(key), sqlight.text(value), sqlight.int(now)],
      dynamic.dynamic,
    )
    |> result.map(fn(_) { Nil })
  }
  |> Ok
}
