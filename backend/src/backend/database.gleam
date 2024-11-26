import backend/database/configuration
import backend/database/file
import backend/database/generated_file
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

pub type Timer

@external(erlang, "backend_ffi", "apply_after")
fn do_apply_after(
  timeout_millisecond: Int,
  callback: fn() -> a,
) -> Result(Timer, b)

@external(erlang, "backend_ffi", "apply_interval")
fn do_apply_interval(
  timeout_millisecond: Int,
  callback: fn() -> a,
) -> Result(Timer, b)

@external(erlang, "backend_ffi", "cancel_timer")
fn do_cancel_timer(timer: Timer) -> Result(a, b)

pub fn apply_after(
  timeout_millisecond: Int,
  callback: fn() -> a,
) -> Result(Timer, Nil) {
  do_apply_after(timeout_millisecond, callback)
  |> result.map_error(fn(_) { Nil })
}

pub fn apply_interval(
  timeout_millisecond: Int,
  callback: fn() -> a,
) -> Result(Timer, Nil) {
  do_apply_interval(timeout_millisecond, callback)
  |> result.map_error(fn(_) { Nil })
}

fn cancel_timer(timer: Timer) -> Result(Nil, Nil) {
  do_cancel_timer(timer)
  |> result.map(fn(_) { Nil })
  |> result.map_error(fn(_) { Nil })
}

type Msg {
  Close(reply_to: Subject(Nil))
  GetConnection(
    pool: Subject(Msg),
    timeout: Int,
    wait_until: Int,
    reply_to: Subject(Option(Connection)),
  )
  PutBack(Connection)
  StartTimer(pool: Subject(Msg), interval_millisecond: Int)
  TimerTick
  RemoveWaiting(waiting_id: Int, reply_to: Subject(Option(Connection)))
}

type Waiting {
  Waiting(
    id: Int,
    timeout: Int,
    wait_until: Int,
    reply_to: Subject(Option(Connection)),
    timer: Result(Timer, Nil),
  )
}

type State {
  State(
    config: feather.Config,
    waiting_id: Int,
    available_connections: List(Connection),
    used_connections: Int,
    waiting: priority_queue.Queue(Waiting),
    sync_timer: Option(Timer),
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

  Ok(Statements(
    config: configuration,
    file:,
    user:,
    page_request:,
    visitor_session:,
    session:,
    generated_file:,
    static_file:,
  ))
}

pub type Connection {
  Connection(
    connection: sqlight.Connection,
    config: feather.Config,
    stmts: Statements,
  )
}

fn new_connection(config: feather.Config, connection: sqlight.Connection) {
  use statements <- result.try(new_statements(connection))

  Ok(Connection(connection:, config:, stmts: statements))
}

fn waiting_compare(a: Waiting, b: Waiting) -> order.Order {
  int.compare(a.wait_until, b.wait_until)
}

fn init(
  config: feather.Config,
  pool_size: Int,
  connection: Connection,
  create_connection: fn() -> Result(Connection, Error),
) -> Result(State, Error) {
  let connections =
    list.try_map(list.repeat(Nil, pool_size - 1), fn(_) { create_connection() })

  case connections {
    Ok(connections) ->
      Ok(State(
        config:,
        waiting_id: 0,
        available_connections: [connection, ..connections],
        used_connections: 0,
        waiting: priority_queue.new(waiting_compare),
        sync_timer: None,
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
      let sync_timer = case state.sync_timer {
        None -> None
        Some(timer) -> {
          let _ = cancel_timer(timer)
          None
        }
      }

      let waiting =
        fold_until(state.waiting, fn(waiting) {
          case priority_queue.pop(waiting) {
            Ok(#(waiting, accumulator)) -> {
              case waiting.timer {
                Ok(timer) -> {
                  let _ = cancel_timer(timer)
                  Nil
                }
                Error(Nil) -> Nil
              }
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
        sync_timer:,
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
            apply_after(timeout, fn() {
              process.send(pool, RemoveWaiting(waiting_id, reply_to))
            })

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
              case waiting.timer {
                Ok(timer) -> {
                  let _ = cancel_timer(timer)
                  Nil
                }
                Error(Nil) -> Nil
              }

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

    StartTimer(pool, interval) -> {
      let _ = apply_interval(interval, fn() { process.send(pool, TimerTick) })
      state
    }
    TimerTick -> {
      let _ =
        feather.connect(state.config)
        |> result.map_error(SqlightError)
        |> result.then(new_connection(state.config, _))
        |> result.then(fn(connection) { set_pragmas(connection) })
        |> result.then(fn(connection) {
          sqlight.exec("PRAGMA wal_checkpoint(PASSIVE);", connection.connection)
          |> result.map_error(SqlightError)
          |> result.map(fn(_) { connection })
        })
        |> result.then(fn(conn) {
          feather.disconnect(conn.connection) |> result.map_error(SqlightError)
        })

      state
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

fn set_pragmas(db: Connection) -> Result(Connection, Error) {
  {
    use _ <- result.try(sqlight.exec(
      "
PRAGMA locking_mode = NORMAL;
PRAGMA journal_size_limit = 16777216;
PRAGMA cache_size = -32768;
PRAGMA cache_shared = ON;
PRAGMA busy_timeout = 1000;
PRAGMA mmap_size = 134217728;
PRAGMA recursive_triggers = 1;
PRAGMA defer_foreign_keys = 0;
PRAGMA encoding = 'UTF-8';
PRAGMA ignore_check_constraints = 0;
PRAGMA legacy_alter_table = 0;
PRAGMA analysis_limit = 0;
PRAGMA auto_vacuum = 0;
PRAGMA automatic_index = 1;
    ",
      db.connection,
    ))

    Ok(db)
  }
  |> result.map_error(SqlightError)
}

pub fn connect(
  file: String,
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

  let config =
    feather.Config(
      ..feather.default_config(),
      file: file,
      page_size: Some(65_536),
    )

  use connection <- result.try(
    feather.connect(config)
    |> result.map_error(SqlightError),
  )
  use connection <- result.try(new_connection(config, connection))

  use _ <- result.try(set_pragmas(connection))

  use _ <- result.try(
    migrate.migrate(migrations, on: connection.connection)
    |> result.map_error(MigrationError),
  )

  use _ <- result.try(
    feather.optimize(connection.connection)
    |> result.map_error(SqlightError),
  )

  use state <- result.try(
    init(config, connections, connection, fn() {
      feather.connect(config)
      |> result.map_error(SqlightError)
      |> result.then(new_connection(config, _))
      |> result.then(set_pragmas)
    }),
  )

  use pool <- result.try(
    actor.start(state, update) |> result.map_error(PoolStartError),
  )

  case sync_interval_millisecond > 0 {
    True -> process.send(pool, StartTimer(pool, sync_interval_millisecond))
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
