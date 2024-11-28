import backend/database/configuration
import backend/database/file
import backend/database/generated_file
import backend/database/page
import backend/database/page_request
import backend/database/session
import backend/database/static_file
import backend/database/user
import backend/database/visitor_session
import birl
import exception
import feather
import feather/migrate
import gleam/erlang
import gleam/erlang/process.{type Subject}
import gleam/int
import gleam/list.{type ContinueOrStop, Continue, Stop}
import gleam/option.{type Option, None, Some}
import gleam/order
import gleam/otp/actor.{type Next}
import gleam/result
import gleamy/priority_queue
import sqlight

@external(erlang, "backend_ffi", "unique_int")
fn unique_int() -> Int

type Msg {
  Close(reply_to: Subject(Nil))
  GetConnection(
    pool: Subject(Msg),
    timeout: Int,
    wait_until: Int,
    reply_to: Subject(Option(Connection)),
  )
  PutBack(Connection)
  TimerTick(pool: Subject(Msg), interval_millisecond: Int)
  RemoveWaiting(waiting_id: Int, reply_to: Subject(Option(Connection)))
}

type Waiting {
  Waiting(
    id: Int,
    timeout: Int,
    wait_until: Int,
    reply_to: Subject(Option(Connection)),
    timer: process.Timer,
  )
}

type State {
  State(
    config: Config,
    waiting_id: Int,
    available_connections: List(Connection),
    used_connections: Int,
    waiting: priority_queue.Queue(Waiting),
    close_subject: Option(Subject(Nil)),
  )
}

pub opaque type Db {
  Db(pool: Subject(Msg))
}

pub type Statements {
  Statements(
    config: configuration.Statements,
    file: file.Statements,
    user: user.Statements,
    page_request: page_request.Statements,
    visitor_session: visitor_session.Statements,
    session: session.Statements,
    generated_file: generated_file.Statements,
    static_file: static_file.Statements,
    page: page.Statements,
  )
}

fn new_statements(connection: sqlight.Connection) -> Result(Statements, Error) {
  use configuration <- result.try(
    configuration.statements(connection) |> result.map_error(SqlightError),
  )

  use file <- result.try(
    file.statements(connection) |> result.map_error(SqlightError),
  )

  use user <- result.try(
    user.statements(connection) |> result.map_error(SqlightError),
  )

  use page_request <- result.try(
    page_request.statements(connection) |> result.map_error(SqlightError),
  )

  use visitor_session <- result.try(
    visitor_session.statements(connection) |> result.map_error(SqlightError),
  )

  use session <- result.try(
    session.statements(connection) |> result.map_error(SqlightError),
  )

  use generated_file <- result.try(
    generated_file.statements(connection) |> result.map_error(SqlightError),
  )

  use static_file <- result.try(
    static_file.statements(connection) |> result.map_error(SqlightError),
  )

  use page <- result.try(
    page.statements(connection) |> result.map_error(SqlightError),
  )

  Ok(Statements(
    config: configuration,
    file:,
    user:,
    page_request:,
    visitor_session:,
    session:,
    generated_file:,
    static_file:,
    page:,
  ))
}

pub type Config {
  Config(
    feather: feather.Config,
    file: Option(String),
    migrations: List(migrate.Migration),
    pool_size: Int,
  )
}

pub type Connection {
  Connection(
    connection: sqlight.Connection,
    number: Int,
    config: Config,
    stmts: Statements,
  )
}

fn set_pragmas_file(db: sqlight.Connection) -> Result(Nil, Error) {
  {
    use _ <- result.try(sqlight.exec(
      "
PRAGMA locking_mode = NORMAL;
PRAGMA journal_size_limit = 67108864;
PRAGMA cache_size = -32768;
PRAGMA cache_shared = 1;

PRAGMA busy_timeout = 5000;
PRAGMA recursive_triggers = 1;
PRAGMA defer_foreign_keys = 0;
PRAGMA encoding = 'UTF-8';
PRAGMA ignore_check_constraints = 0;
PRAGMA legacy_alter_table = 0;
PRAGMA analysis_limit = 0;
PRAGMA auto_vacuum = 0;
PRAGMA automatic_index = 1;
    ",
      db,
    ))

    Ok(Nil)
  }
  |> result.map_error(SqlightError)
}

fn set_pragmas_memory(db: sqlight.Connection) -> Result(Nil, Error) {
  {
    use _ <- result.try(sqlight.exec(
      "
PRAGMA cache_size = -32768;

PRAGMA busy_timeout = 1000;
PRAGMA recursive_triggers = 1;
PRAGMA defer_foreign_keys = 0;
PRAGMA encoding = 'UTF-8';
PRAGMA ignore_check_constraints = 0;
PRAGMA legacy_alter_table = 0;
PRAGMA analysis_limit = 0;
PRAGMA auto_vacuum = 0;
PRAGMA automatic_index = 1;
    ",
      db,
    ))

    Ok(Nil)
  }
  |> result.map_error(SqlightError)
}

fn new_connection(config: Config, number: Int) -> Result(Connection, Error) {
  use connection <- result.try(
    feather.connect(config.feather)
    |> result.map_error(SqlightError),
  )

  use _ <- result.try(case config.file {
    Some(_) -> set_pragmas_file(connection)
    None -> set_pragmas_memory(connection)
  })

  use _ <- result.try(case number {
    1 ->
      migrate.migrate(config.migrations, on: connection)
      |> result.map_error(MigrationError)
    _ -> Ok(Nil)
  })

  use stmts <- result.try(new_statements(connection))

  Ok(Connection(connection:, number:, config:, stmts:))
}

fn waiting_compare(a: Waiting, b: Waiting) -> order.Order {
  int.compare(a.wait_until, b.wait_until)
}

fn init(
  config: Config,
  pool_size: Int,
  connection: Connection,
  create_connection: fn(Int) -> Result(Connection, Error),
) -> Result(State, Error) {
  let connections =
    case pool_size > 1 {
      True -> list.range(2, pool_size)
      False -> []
    }
    |> list.try_map(fn(number) { create_connection(number) })

  case connections {
    Ok(connections) ->
      Ok(State(
        config:,
        waiting_id: 0,
        available_connections: [connection, ..connections],
        used_connections: 0,
        waiting: priority_queue.new(waiting_compare),
        close_subject: None,
      ))
    Error(error) -> Error(error)
  }
}

fn fold_until(accumulator: a, callback: fn(a) -> ContinueOrStop(a)) -> a {
  case callback(accumulator) {
    Stop(accumulator) -> accumulator
    Continue(accumulator) -> fold_until(accumulator, callback)
  }
}

fn update(msg: Msg, state: State) -> Next(Msg, State) {
  let state = case msg {
    Close(reply_to) -> {
      let waiting =
        fold_until(state.waiting, fn(waiting) {
          case priority_queue.pop(waiting) {
            Ok(#(waiting, accumulator)) -> {
              process.cancel_timer(waiting.timer)
              process.send(waiting.reply_to, None)
              Continue(accumulator)
            }
            Error(Nil) -> Stop(waiting)
          }
        })

      list.map(state.available_connections, fn(conn) {
        feather.disconnect(conn.connection)
      })

      State(
        ..state,
        close_subject: Some(reply_to),
        available_connections: [],
        waiting:,
      )
    }
    GetConnection(pool, timeout, wait_until, reply_to) -> {
      case state.available_connections {
        [connection, ..rest] -> {
          process.send(reply_to, Some(connection))

          State(
            ..state,
            available_connections: rest,
            used_connections: state.used_connections + 1,
          )
        }
        [] -> {
          let waiting_id = state.waiting_id + 1

          let timer =
            process.send_after(
              pool,
              timeout,
              RemoveWaiting(waiting_id, reply_to),
            )

          State(
            ..state,
            waiting_id:,
            waiting: priority_queue.push(
              state.waiting,
              Waiting(waiting_id, timeout, wait_until, reply_to, timer),
            ),
          )
        }
      }
    }
    PutBack(connection) ->
      case state.close_subject {
        None ->
          case priority_queue.pop(state.waiting) {
            Ok(#(waiting, rest)) -> {
              process.cancel_timer(waiting.timer)
              process.send(waiting.reply_to, Some(connection))

              State(..state, waiting: rest)
            }
            Error(Nil) -> {
              State(
                ..state,
                available_connections: [
                  connection,
                  ..state.available_connections
                ],
                used_connections: state.used_connections - 1,
              )
            }
          }

        Some(_) -> {
          let _ = feather.disconnect(connection.connection)

          State(..state, used_connections: state.used_connections - 1)
        }
      }

    TimerTick(pool, interval) -> {
      case state.close_subject {
        Some(_) -> state
        None -> {
          let _ =
            new_connection(state.config, -1)
            |> result.then(fn(connection) {
              sqlight.exec(
                "
ANALYZE;
PRAGMA wal_checkpoint(PASSIVE);
",
                connection.connection,
              )
              |> result.map_error(SqlightError)
              |> result.map(fn(_) { connection })
            })
            |> result.then(fn(conn) {
              feather.disconnect(conn.connection)
              |> result.map_error(SqlightError)
            })

          process.send_after(pool, interval, TimerTick(pool, interval))
          state
        }
      }
    }
    RemoveWaiting(waiting_id, reply_to) -> {
      process.send(reply_to, None)

      State(
        ..state,
        waiting: state.waiting
          |> priority_queue.to_list
          |> list.filter(fn(waiting) { waiting.id != waiting_id })
          |> priority_queue.from_list(waiting_compare),
      )
    }
  }

  case state.available_connections, state.used_connections {
    [], 0 -> {
      case state.close_subject {
        None -> Nil
        Some(close_subject) -> process.send(close_subject, Nil)
      }
      actor.Stop(process.Normal)
    }
    _, _ -> actor.Continue(state, None)
  }
}

pub type Error {
  PrivateDirectoryNotFound
  MigrationError(migrate.MigrationError)
  SqlightError(sqlight.Error)
  PoolStartError(actor.StartError)
  WaitForConnectionError(process.CallError(Nil))
  WaitForConnectionTimeout(timeout_millisecond: Int)
}

pub fn connect(
  file: Option(String),
  connections: Int,
  sync_interval_millisecond: Int,
) -> Result(Db, Error) {
  use priv_dir <- result.try(
    erlang.priv_directory("backend")
    |> result.map_error(fn(_) { PrivateDirectoryNotFound }),
  )

  use migrations <- result.try(
    migrate.get_migrations(priv_dir <> "/migrations")
    |> result.map_error(MigrationError),
  )

  let connections = case connections < 1 {
    True -> 1
    False -> connections
  }

  let config =
    Config(
      feather: feather.Config(
        ..feather.default_config(),
        file: option.unwrap(
          file,
          "file:memdb"
            <> int.to_string(unique_int())
            <> "?mode=memory&cache=shared",
        ),
        page_size: Some(65_536),
        mmap_size: case file {
          Some(_) -> Some(536_870_912)
          None -> None
        },
        journal_mode: case file {
          Some(_) -> feather.JournalWal
          None -> feather.JournalOff
        },
        synchronous: feather.SyncOff,
        temp_store: feather.TempStoreMemory,
      ),
      file:,
      migrations:,
      pool_size: connections,
    )

  use connection <- result.try(new_connection(config, 1))

  use _ <- result.try(
    feather.optimize(connection.connection)
    |> result.map_error(SqlightError),
  )

  use state <- result.try(
    init(config, connections, connection, fn(number) {
      new_connection(config, number)
    }),
  )

  use pool <- result.try(
    actor.start(state, update) |> result.map_error(PoolStartError),
  )

  case sync_interval_millisecond > 0 {
    True -> {
      process.send_after(
        pool,
        sync_interval_millisecond,
        TimerTick(pool, sync_interval_millisecond),
      )
      Nil
    }
    False -> Nil
  }

  Ok(Db(pool:))
}

pub fn connection(
  db: Db,
  wait_timeout_millisecond: Int,
  map_error: fn(Error) -> b,
  context: fn(Connection) -> Result(a, b),
) -> Result(a, b) {
  let wait_until =
    { birl.now() |> birl.to_unix_milli } + wait_timeout_millisecond

  let connection =
    process.try_call_forever(db.pool, GetConnection(
      db.pool,
      wait_timeout_millisecond,
      wait_until,
      _,
    ))

  use connection <- result.try(case connection {
    Ok(Some(connection)) -> Ok(connection)
    Ok(None) ->
      Error(WaitForConnectionTimeout(wait_timeout_millisecond) |> map_error)
    Error(error) -> Error(WaitForConnectionError(error) |> map_error)
  })

  use <- exception.defer(fn() { process.send(db.pool, PutBack(connection)) })

  context(connection)
}

pub fn transaction(
  db: Db,
  wait_timeout_millisecond: Int,
  map_error: fn(Error) -> b,
  context: fn(Connection) -> Result(a, b),
) -> Result(a, b) {
  use connection <- connection(db, wait_timeout_millisecond, map_error)

  transaction_block(connection, map_error, context)
}

pub fn disconnect(db: Db, within_millisecond: Int) {
  process.call(db.pool, Close, within_millisecond)
}

fn transaction_block(
  connection: Connection,
  map_error: fn(Error) -> b,
  context: fn(Connection) -> Result(a, b),
) -> Result(a, b) {
  let map = fn(map: fn(x) -> Error) -> fn(x) -> b {
    fn(error: x) {
      map(error)
      |> map_error
    }
  }

  use _ <- result.then(
    sqlight.exec("BEGIN TRANSACTION;", connection.connection)
    |> result.map_error(map(SqlightError)),
  )

  let result = context(connection)

  case result {
    Ok(_) -> {
      use _ <- result.then(
        sqlight.exec("COMMIT TRANSACTION;", connection.connection)
        |> result.map_error(map(SqlightError)),
      )

      result
    }
    Error(_) -> {
      let _ =
        sqlight.exec("ROLLBACK TRANSACTION;", connection.connection)
        |> result.map_error(map(SqlightError))

      result
    }
  }
}
