import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/option.{type Option, None, Some}
import gleam/result
import sqlight.{type Connection, type Error}
import widgets/helper/dynamic_helper

pub type Session {
  Session(
    id: Int,
    key: BitArray,
    user_id: Int,
    created_at: Int,
    expires_at: Int,
    user_agent: Option(String),
  )
}

pub fn decoder() -> fn(Dynamic) -> Result(Session, List(DecodeError)) {
  dynamic.tuple6(
    dynamic.int,
    dynamic.bit_array,
    dynamic.int,
    dynamic.int,
    dynamic.int,
    dynamic.optional(dynamic.string),
  )
  |> dynamic_helper.map(fn(value) {
    let #(id, key, user_id, created_at, expires_at, user_agent) = value
    Ok(Session(id:, key:, user_id:, created_at:, expires_at:, user_agent:))
  })
}

pub fn get(db: Connection, id: Int, now: Int) -> Result(Option(Session), Error) {
  sqlight.query(
    "
SELECT
  \"id\",
  \"key\",
  \"user_id\",
  \"created_at\",
  \"expires_at\",
  \"user_agent\"
FROM
  \"session\"
WHERE
  \"id\" = ?
  AND
  \"expires_at\" >= ?;
    ",
    db,
    [sqlight.int(id), sqlight.int(now)],
    decoder(),
  )
  |> result.map(fn(values) {
    case values {
      [] -> None
      [value, ..] -> Some(value)
    }
  })
}

pub fn get_by_key(
  db: Connection,
  key: BitArray,
  now: Int,
) -> Result(Option(Session), Error) {
  sqlight.query(
    "
SELECT
  \"id\",
  \"key\",
  \"user_id\",
  \"created_at\",
  \"expires_at\",
  \"user_agent\"
FROM
  \"session\"
WHERE
  \"key\" = ?
  AND
  \"expires_at\" >= ?;
    ",
    db,
    [sqlight.blob(key), sqlight.int(now)],
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
  key: BitArray,
  user_id: Int,
  lifetime_milliseconds: Int,
  user_agent: Option(String),
  now: Int,
) -> Result(Session, Error) {
  let expires_at = now + lifetime_milliseconds

  use session <- result.try(sqlight.query(
    "
INSERT INTO
  \"session\"
  (\"key\", \"user_id\", \"created_at\", \"expires_at\", \"user_agent\")
VALUES
  (?, ?, ?, ?, ?)
RETURNING
  \"id\",
  \"key\",
  \"user_id\",
  \"created_at\",
  \"expires_at\",
  \"user_agent\";
        ",
    db,
    [
      sqlight.blob(key),
      sqlight.int(user_id),
      sqlight.int(now),
      sqlight.int(expires_at),
      sqlight.nullable(sqlight.text, user_agent),
    ],
    decoder(),
  ))

  case session {
    [] ->
      Error(sqlight.SqlightError(
        sqlight.Notfound,
        "Could not find inserted session",
        -1,
      ))
    [session, ..] -> Ok(session)
  }
}

pub fn update(
  db: Connection,
  session: Session,
  lifetime_milliseconds: Option(Int),
  user_agent: Option(String),
  now: Int,
) -> Result(Session, Error) {
  let session = case lifetime_milliseconds {
    None -> session
    Some(lifetime_milliseconds) ->
      Session(..session, expires_at: lifetime_milliseconds + now)
  }

  let session = case user_agent {
    None -> session
    Some(user_agent) -> Session(..session, user_agent: Some(user_agent))
  }

  use session <- result.try(sqlight.query(
    "
UPDATE
  \"session\"
SET
  \"key\" = ?,
  \"user_id\" = ?,
  \"created_at\" = ?,
  \"expires_at\" = ?,
  \"user_agent\" = ?
WHERE
  \"id\" = ?
RETURNING
  \"id\",
  \"key\",
  \"user_id\",
  \"created_at\",
  \"expires_at\",
  \"user_agent\";
        ",
    db,
    [
      sqlight.blob(session.key),
      sqlight.int(session.user_id),
      sqlight.int(session.created_at),
      sqlight.int(session.expires_at),
      sqlight.nullable(sqlight.text, session.user_agent),
      sqlight.int(session.id),
    ],
    decoder(),
  ))

  case session {
    [] ->
      Error(sqlight.SqlightError(
        sqlight.Notfound,
        "Could not find updated session",
        -1,
      ))
    [session, ..] -> Ok(session)
  }
}
