import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/option.{type Option, None, Some}
import gleam/result
import sqlight.{type Connection, type Error}
import widgets/helper/dynamic_helper

pub type PageRequest {
  PageRequest(id: Int, visitor_id: Int, path: String, time: Int)
}

pub type Statements {
  Statements(
    get: fn(Int) -> Result(Option(PageRequest), Error),
    get_path_id: fn(String) -> Result(Int, Error),
    insert_new: fn(Int, String, Int) -> Result(PageRequest, Error),
    insert_new_with_path_id: fn(Int, Int, Int) -> Result(PageRequest, Error),
  )
}

pub fn decoder() -> fn(Dynamic) -> Result(PageRequest, List(DecodeError)) {
  dynamic.tuple4(dynamic.int, dynamic.int, dynamic.string, dynamic.int)
  |> dynamic_helper.map(fn(value) {
    let #(id, visitor_id, path, time) = value
    Ok(PageRequest(id:, visitor_id:, path:, time:))
  })
}

pub fn statements(db: Connection) -> Result(Statements, Error) {
  use get <- result.try(get(db))
  use get_path_id <- result.try(get_path_id(db))
  use insert_new_with_path_id <- result.try(insert_new_with_path_id(db, get))
  use insert_new <- result.try(insert_new(get_path_id, insert_new_with_path_id))

  Ok(Statements(get:, get_path_id:, insert_new:, insert_new_with_path_id:))
}

fn get(
  db: Connection,
) -> Result(fn(Int) -> Result(Option(PageRequest), Error), Error) {
  fn(id: Int) -> Result(Option(PageRequest), Error) {
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
  |> Ok
}

fn get_path_id(
  db: Connection,
) -> Result(fn(String) -> Result(Int, Error), Error) {
  fn(path: String) -> Result(Int, Error) {
    use page_id <- result.try(case
      sqlight.query(
        "
SELECT
  \"id\"
FROM
  \"request_path\"
WHERE
  \"path\" = ?;
        ",
        db,
        [sqlight.text(path)],
        dynamic.element(0, dynamic.int),
      )
    {
      Ok(path_id) ->
        case path_id {
          [path_id] -> Ok(Some(path_id))
          _ -> Ok(None)
        }
      Error(error) -> Error(error)
    })

    case page_id {
      Some(page_id) -> Ok(page_id)
      None -> {
        use _ <- result.try(sqlight.query(
          "
INSERT OR IGNORE INTO
  \"request_path\"
  (\"path\")
VALUES
  (?);
    ",
          db,
          [sqlight.text(path)],
          dynamic.dynamic,
        ))

        case
          sqlight.query(
            "
SELECT
  \"id\"
FROM
  \"request_path\"
WHERE
  \"path\" = ?;
        ",
            db,
            [sqlight.text(path)],
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
        }
      }
    }
  }
  |> Ok
}

fn insert_new(
  get_path_id: fn(String) -> Result(Int, Error),
  insert_new_with_path_id: fn(Int, Int, Int) -> Result(PageRequest, Error),
) -> Result(fn(Int, String, Int) -> Result(PageRequest, Error), Error) {
  fn(visitor_id: Int, path: String, now: Int) -> Result(PageRequest, Error) {
    use path_id <- result.try(get_path_id(path))

    insert_new_with_path_id(visitor_id, path_id, now)
  }
  |> Ok
}

fn insert_new_with_path_id(
  db: Connection,
  get: fn(Int) -> Result(Option(PageRequest), Error),
) -> Result(fn(Int, Int, Int) -> Result(PageRequest, Error), Error) {
  fn(visitor_id: Int, path_id: Int, now: Int) -> Result(PageRequest, Error) {
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

    use page_request <- result.try(get(id))

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
  |> Ok
}
