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
    get_or_set: fn(String, fn() -> #(String, Int)) ->
      Result(Configuration, Error),
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
  use get_or_set <- result.try(get_or_set(get, set))

  Ok(Statements(get:, set:, get_or_set:))
}

fn get(
  db: Connection,
) -> Result(fn(String) -> Result(Option(Configuration), Error), Error) {
  use select <- result.try(sqlight.prepare(
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
    decoder(),
  ))

  fn(key: String) -> Result(Option(Configuration), Error) {
    sqlight.query_prepared(select, [sqlight.text(key)])
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
  use insert <- result.try(sqlight.prepare(
    "
INSERT INTO
  \"configuration\"
  (\"key\", \"value\", \"created_at\")
VALUES
  (?, ?, ?);
    ",
    db,
    dynamic.dynamic,
  ))

  fn(key: String, value: String, now: Int) {
    sqlight.query_prepared(insert, [
      sqlight.text(key),
      sqlight.text(value),
      sqlight.int(now),
    ])
    |> result.map(fn(_) { Nil })
  }
  |> Ok
}

fn get_or_set(
  get: fn(String) -> Result(Option(Configuration), Error),
  set: fn(String, String, Int) -> Result(Nil, Error),
) -> Result(
  fn(String, fn() -> #(String, Int)) -> Result(Configuration, Error),
  Error,
) {
  fn(key: String, default: fn() -> #(String, Int)) -> Result(
    Configuration,
    Error,
  ) {
    use configuration <- result.try(get(key))

    case configuration {
      Some(configuration) -> Ok(configuration)
      None -> {
        let #(value, now) = default()

        use _ <- result.try(set(key, value, now))
        use configuration <- result.try(get(key))

        case configuration {
          Some(configuration) -> Ok(configuration)
          None ->
            Error(sqlight.SqlightError(
              sqlight.Notfound,
              "Could not get newly created configuration",
              -1,
            ))
        }
      }
    }
  }
  |> Ok
}
