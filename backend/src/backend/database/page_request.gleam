import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/option.{type Option, None, Some}
import gleam/result
import sqlight.{type Connection, type Error}
import widgets/helper/dynamic_helper

pub type PageRequest {
  PageRequest(id: Int, visitor_id: Int, path: String, time: Int)
}

pub fn decoder() -> fn(Dynamic) -> Result(PageRequest, List(DecodeError)) {
  dynamic.tuple4(dynamic.int, dynamic.int, dynamic.string, dynamic.int)
  |> dynamic_helper.map(fn(value) {
    let #(id, visitor_id, path, time) = value
    Ok(PageRequest(id:, visitor_id:, path:, time:))
  })
}

pub fn get(db: Connection, id: Int) -> Result(Option(PageRequest), Error) {
  sqlight.query(
    "
SELECT
  \"r\".\"id\",
  \"r\".\"visitor_id\",
  \"p\".\"path\",
  \"r\".\"time\"
FROM
  \"page_request\" AS \"r\"
  INNER JOIN \"request_path\" AS \"p\" ON \"r\".\"request_path_id\" = \"p\".\"id\"
WHERE
  \"r\".\"id\" = ?;
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

pub fn insert_new(
  db: Connection,
  visitor_id: Int,
  path: String,
  now: Int,
) -> Result(PageRequest, Error) {
  use path_id <- result.try(case
    sqlight.query(
      "
INSERT OR IGNORE INTO
  \"request_path\"
  (\"path\")
VALUES
  (?);

SELECT
  \"id\"
FROM
  \"request_path\"
WHERE
  \"path\" = ?;
        ",
      db,
      [sqlight.text(path), sqlight.text(path)],
      dynamic.element(0, dynamic.int),
    )
  {
    Ok(path_id) ->
      case path_id {
        [path_id] -> Ok(path_id)
        _ ->
          Error(sqlight.SqlightError(
            sqlight.Notfound,
            "Could not get newly created request path id",
            -1,
          ))
      }
    Error(error) -> Error(error)
  })

  use id <- result.try(case
    sqlight.query(
      "
INSERT INTO
  \"page_request\"
  (\"visitor_id\", \"request_path_id\", \"time\")
VALUES
  (?, ?, ?)
RETURNING id;
      ",
      db,
      [sqlight.int(visitor_id), sqlight.int(path_id), sqlight.int(now)],
      dynamic.element(0, dynamic.int),
    )
  {
    Ok(id) ->
      case id {
        [id] -> Ok(id)
        _ ->
          Error(sqlight.SqlightError(
            sqlight.Notfound,
            "Could not get newly created page request id",
            -1,
          ))
      }
    Error(error) -> Error(error)
  })

  use page_request <- result.try(get(db, id))

  case page_request {
    None ->
      Error(sqlight.SqlightError(
        sqlight.Notfound,
        "Could not find inserted page request",
        -1,
      ))
    Some(page_request) -> Ok(page_request)
  }
}
