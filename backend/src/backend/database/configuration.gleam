import birl
import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/option.{type Option, None, Some}
import gleam/result
import sqlight.{type Connection, type Error}
import widgets/helper/dynamic_helper

pub type Configuration {
  Configuration(id: Int, key: String, value: String, created_at: Int)
}

pub fn decoder() -> fn(Dynamic) -> Result(Configuration, List(DecodeError)) {
  dynamic.tuple4(dynamic.int, dynamic.string, dynamic.string, dynamic.int)
  |> dynamic_helper.map(fn(value) {
    let #(id, key, value, created_at) = value
    Ok(Configuration(id:, key:, value:, created_at:))
  })
}

pub fn get(db: Connection, key: String) -> Result(Option(Configuration), Error) {
  sqlight.query(
    "
SELECT
  \"id\",
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

pub fn set(db: Connection, key: String, value: String) -> Result(Nil, Error) {
  sqlight.query(
    "
INSERT INTO
  \"configuration\"
  (\"key\", \"value\", \"created_at\")
VALUES
  (?, ?, ?);
    ",
    db,
    [
      sqlight.text(key),
      sqlight.text(value),
      sqlight.int(birl.now() |> birl.to_unix_milli),
    ],
    dynamic.dynamic,
  )
  |> result.map(fn(_) { Nil })
}
