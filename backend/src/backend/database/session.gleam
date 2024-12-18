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

pub type Statements {
  Statements(
    get: fn(Int, Int) -> Result(Option(Session), Error),
    get_by_key: fn(BitArray, Int) -> Result(Option(Session), Error),
    insert_new_or_update: fn(BitArray, Int, Int, Option(String), Int) ->
      Result(Session, Error),
    update: fn(Session, Option(Int), Option(String), Int) ->
      Result(Session, Error),
    update_by_key: fn(BitArray, Option(Int), Option(String), Int) ->
      Result(Session, Error),
  )
}

pub fn statements(db: Connection) -> Result(Statements, Error) {
  use get <- result.try(get(db))
  use get_by_key <- result.try(get_by_key(db))
  use insert_new_or_update <- result.try(insert_new_or_update(db))
  use update <- result.try(update(db))
  use update_by_key <- result.try(update_by_key(db))

  Ok(Statements(
    get:,
    get_by_key:,
    insert_new_or_update:,
    update:,
    update_by_key:,
  ))
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

fn get(
  db: Connection,
) -> Result(fn(Int, Int) -> Result(Option(Session), Error), Error) {
  use select <- result.try(sqlight.prepare(
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
    decoder(),
  ))
  fn(id: Int, now: Int) -> Result(Option(Session), Error) {
    sqlight.query_prepared(select, [sqlight.int(id), sqlight.int(now)])
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
) -> Result(fn(BitArray, Int) -> Result(Option(Session), Error), Error) {
  use select <- result.try(sqlight.prepare(
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
    decoder(),
  ))
  fn(key: BitArray, now: Int) -> Result(Option(Session), Error) {
    sqlight.query_prepared(select, [sqlight.blob(key), sqlight.int(now)])
    |> result.map(fn(values) {
      case values {
        [] -> None
        [value, ..] -> Some(value)
      }
    })
  }
  |> Ok
}

fn insert_new_or_update(
  db: Connection,
) -> Result(
  fn(BitArray, Int, Int, Option(String), Int) -> Result(Session, Error),
  Error,
) {
  use insert <- result.try(sqlight.prepare(
    "
INSERT INTO
  \"session\"
  (\"key\", \"user_id\", \"created_at\", \"expires_at\", \"user_agent\")
VALUES
  (?, ?, ?, ?, ?)
ON CONFLICT (\"key\") DO UPDATE SET
  \"user_id\" = EXCLUDED.\"user_id\",
  \"expires_at\" = EXCLUDED.\"expires_at\",
  \"user_agent\" = EXCLUDED.\"user_agent\"
RETURNING
  \"id\",
  \"key\",
  \"user_id\",
  \"created_at\",
  \"expires_at\",
  \"user_agent\";
        ",
    db,
    decoder(),
  ))
  fn(
    key: BitArray,
    user_id: Int,
    lifetime_milliseconds: Int,
    user_agent: Option(String),
    now: Int,
  ) -> Result(Session, Error) {
    let expires_at = now + lifetime_milliseconds

    use session <- result.try(
      sqlight.query_prepared(insert, [
        sqlight.blob(key),
        sqlight.int(user_id),
        sqlight.int(now),
        sqlight.int(expires_at),
        sqlight.nullable(sqlight.text, user_agent),
      ]),
    )

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
  |> Ok
}

fn update(
  db: Connection,
) -> Result(
  fn(Session, Option(Int), Option(String), Int) -> Result(Session, Error),
  Error,
) {
  use update <- result.try(sqlight.prepare(
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
  AND
  \"expires_at\" >= ?
RETURNING
  \"id\",
  \"key\",
  \"user_id\",
  \"created_at\",
  \"expires_at\",
  \"user_agent\";
        ",
    db,
    decoder(),
  ))
  fn(
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

    use session <- result.try(
      sqlight.query_prepared(update, [
        sqlight.blob(session.key),
        sqlight.int(session.user_id),
        sqlight.int(session.created_at),
        sqlight.int(session.expires_at),
        sqlight.nullable(sqlight.text, session.user_agent),
        sqlight.int(session.id),
        sqlight.int(now),
      ]),
    )

    case session {
      [] ->
        Error(sqlight.SqlightError(
          sqlight.Notfound,
          "Could not find session",
          -1,
        ))
      [session, ..] -> Ok(session)
    }
  }
  |> Ok
}

fn update_by_key(
  db: Connection,
) -> Result(
  fn(BitArray, Option(Int), Option(String), Int) -> Result(Session, Error),
  Error,
) {
  use update_user_agent <- result.try(sqlight.prepare(
    "
UPDATE
  \"session\"
SET
  \"user_agent\" = ?
WHERE
  \"key\" = ?
  AND
  \"expires_at\" >= ?
RETURNING
  \"id\",
  \"key\",
  \"user_id\",
  \"created_at\",
  \"expires_at\",
  \"user_agent\";
        ",
    db,
    decoder(),
  ))

  use update_lifetime_and_user_agent <- result.try(sqlight.prepare(
    "
UPDATE
  \"session\"
SET
  \"expires_at\" = ?,
  \"user_agent\" = ?
WHERE
  \"key\" = ?
  AND
  \"expires_at\" >= ?
RETURNING
  \"id\",
  \"key\",
  \"user_id\",
  \"created_at\",
  \"expires_at\",
  \"user_agent\";
        ",
    db,
    decoder(),
  ))
  fn(
    key: BitArray,
    lifetime_milliseconds: Option(Int),
    user_agent: Option(String),
    now: Int,
  ) -> Result(Session, Error) {
    case lifetime_milliseconds {
      None -> {
        use session <- result.try(
          sqlight.query_prepared(update_user_agent, [
            sqlight.nullable(sqlight.text, user_agent),
            sqlight.blob(key),
            sqlight.int(now),
          ]),
        )

        case session {
          [] ->
            Error(sqlight.SqlightError(
              sqlight.Notfound,
              "Could not find session",
              -1,
            ))
          [session, ..] -> Ok(session)
        }
      }
      Some(lifetime_milliseconds) -> {
        use session <- result.try(
          sqlight.query_prepared(update_lifetime_and_user_agent, [
            sqlight.int(now + lifetime_milliseconds),
            sqlight.nullable(sqlight.text, user_agent),
            sqlight.blob(key),
            sqlight.int(now),
          ]),
        )

        case session {
          [] ->
            Error(sqlight.SqlightError(
              sqlight.Notfound,
              "Could not find session",
              -1,
            ))
          [session, ..] -> Ok(session)
        }
      }
    }
  }
  |> Ok
}
