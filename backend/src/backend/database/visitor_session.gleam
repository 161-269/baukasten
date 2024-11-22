import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/option.{type Option, None, Some}
import gleam/result
import sqlight.{type Connection, type Error}
import widgets/helper/dynamic_helper

pub type VisitorSession {
  VisitorSession(session_key: BitArray, visitor_id: Int, created_at: Int)
}

pub type Statements {
  Statements(
    get_by_session_key: fn(BitArray) -> Result(Option(VisitorSession), Error),
    get_by_visitor_id: fn(Int) -> Result(Option(VisitorSession), Error),
    insert_new: fn(BitArray, Int) -> Result(VisitorSession, Error),
    get_by_session_key_or_insert_new: fn(BitArray, Int) ->
      Result(VisitorSession, Error),
  )
}

pub fn decoder() -> fn(Dynamic) -> Result(VisitorSession, List(DecodeError)) {
  dynamic.tuple3(dynamic.bit_array, dynamic.int, dynamic.int)
  |> dynamic_helper.map(fn(value) {
    let #(session_key, visitor_id, created_at) = value
    Ok(VisitorSession(session_key:, visitor_id:, created_at:))
  })
}

pub fn statements(db: Connection) -> Result(Statements, Error) {
  use get_by_session_key <- result.try(get_by_session_key(db))
  use get_by_visitor_id <- result.try(get_by_visitor_id(db))
  use insert_new <- result.try(insert_new(db))
  use get_by_session_key_or_insert_new <- result.try(
    get_by_session_key_or_insert_new(get_by_session_key, insert_new),
  )

  Ok(Statements(
    get_by_session_key:,
    get_by_visitor_id:,
    insert_new:,
    get_by_session_key_or_insert_new:,
  ))
}

fn get_by_session_key(
  db: Connection,
) -> Result(fn(BitArray) -> Result(Option(VisitorSession), Error), Error) {
  fn(session_key: BitArray) -> Result(Option(VisitorSession), Error) {
    sqlight.query(
      "
SELECT
  \"session_key\",
  \"visitor_id\",
  \"created_at\"
FROM
  \"visitor_session\"
WHERE
  \"session_key\" = ?;
    ",
      db,
      [sqlight.blob(session_key)],
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

fn get_by_visitor_id(
  db: Connection,
) -> Result(fn(Int) -> Result(Option(VisitorSession), Error), Error) {
  fn(visitor_id: Int) -> Result(Option(VisitorSession), Error) {
    sqlight.query(
      "
SELECT
  \"session_key\",
  \"visitor_id\",
  \"created_at\"
FROM
  \"visitor_session\"
WHERE
  \"visitor_id\" = ?;
    ",
      db,
      [sqlight.int(visitor_id)],
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
) -> Result(fn(BitArray, Int) -> Result(VisitorSession, Error), Error) {
  fn(session_key: BitArray, now: Int) -> Result(VisitorSession, Error) {
    use visitor_id <- result.try(case
      sqlight.query(
        "
INSERT INTO 
  \"visitor\"
  DEFAULT VALUES
RETURNING
  \"id\";
      ",
        db,
        [],
        dynamic.element(0, dynamic.int),
      )
    {
      Ok(visitor_id) ->
        case visitor_id {
          [visitor_id] -> Ok(visitor_id)
          _ ->
            Error(sqlight.SqlightError(
              sqlight.Notfound,
              "Could not get newly created visitor id",
              -1,
            ))
        }
      Error(error) -> Error(error)
    })

    use visitor_session <- result.try(sqlight.query(
      "
INSERT INTO
  \"visitor_session\"
  (\"session_key\", \"visitor_id\", \"created_at\")
VALUES
  (?, ?, ?)
RETURNING
  \"session_key\",
  \"visitor_id\",
  \"created_at\";
        ",
      db,
      [sqlight.blob(session_key), sqlight.int(visitor_id), sqlight.int(now)],
      decoder(),
    ))

    case visitor_session {
      [] ->
        Error(sqlight.SqlightError(
          sqlight.Notfound,
          "Could not find inserted visitor session",
          -1,
        ))
      [visitor_session, ..] -> Ok(visitor_session)
    }
  }
  |> Ok
}

fn get_by_session_key_or_insert_new(
  get_by_session_key: fn(BitArray) -> Result(Option(VisitorSession), Error),
  insert_new: fn(BitArray, Int) -> Result(VisitorSession, Error),
) -> Result(fn(BitArray, Int) -> Result(VisitorSession, Error), Error) {
  fn(session_key: BitArray, now: Int) -> Result(VisitorSession, Error) {
    use visitor_session <- result.try(get_by_session_key(session_key))

    case visitor_session {
      None -> insert_new(session_key, now)
      Some(visitor_session) -> Ok(visitor_session)
    }
  }
  |> Ok
}
