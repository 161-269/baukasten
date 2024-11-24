import backend/database.{type Db}
import backend/router
import backend/tailwind
import birl
import gleam/erlang/process.{type Pid, type Subject}
import gleam/io
import gleam/option.{type Option, None, Some}
import gleam/otp/actor.{type Next}
import gleam/result
import mist
import simplifile
import sqlight
import wisp
import wisp/wisp_mist

type Msg {
  Started(Subject(Msg))
  StartServer
  RestartServer
  StopServer(reply_to: Subject(Nil))
  WispPid(Pid)
  WispStartingFailed
}

type Server {
  Server(db: Db, secret_key_base: String, wisp_server: Option(Pid))
}

type State {
  State(self: Option(Subject(Msg)), server: Option(Server))
}

fn update(msg: Msg, state: State) -> Next(Msg, State) {
  use self <-
    fn(next) {
      case state.self, msg {
        None, Started(self) ->
          actor.Continue(State(..state, self: Some(self)), None)
        None, _ -> actor.continue(state)
        Some(self), _ -> next(self)
      }
    }

  let stop_server = fn(state: State) {
    case state.server {
      Some(server) -> {
        database.disconnect(server.db, 2000)

        case server.wisp_server {
          None -> Nil
          Some(wisp_server) -> process.kill(wisp_server)
        }

        State(..state, server: None)
      }
      None -> state
    }
  }

  case msg {
    Started(self) -> State(..state, self: Some(self)) |> actor.continue

    WispPid(wisp_pid) ->
      case state.server {
        None -> {
          process.kill(wisp_pid)
          state |> actor.continue
        }
        Some(server) -> {
          State(
            ..state,
            server: Some(Server(..server, wisp_server: Some(wisp_pid))),
          )
          |> actor.continue
        }
      }

    StartServer -> {
      use <-
        fn(next) {
          case state.server {
            None -> next()
            Some(Server(_, _, None)) -> update(RestartServer, state)
            Some(_) -> state |> actor.continue
          }
        }

      case start_server(self) {
        Ok(server) -> State(..state, server: Some(server)) |> actor.continue
        Error(Nil) -> {
          io.println_error("")
          io.println_error("Could not start server")
          io.println_error("Retrying in 1 second ...")
          io.println_error("")

          process.send_after(self, 1000, StartServer)

          state |> actor.continue
        }
      }
    }

    WispStartingFailed -> {
      io.println_error("")
      io.println_error("Could not start wisp server")
      io.println_error("Retrying in 1 second ...")
      io.println_error("")

      process.send_after(self, 1000, RestartServer)

      state |> actor.continue
    }

    StopServer(reply_to) -> {
      stop_server(state)

      process.send(reply_to, Nil)
      actor.Stop(process.Normal)
    }

    RestartServer -> {
      let state = stop_server(state)
      update(StartServer, state)
    }
  }
}

fn start_server(self: Subject(Msg)) -> Result(Server, Nil) {
  use _ <- result.try(
    simplifile.create_directory_all("./data")
    |> result.map_error(fn(error) {
      io.println_error("Error creating data directory:")
      io.debug(error)
      Nil
    }),
  )

  use db <- result.try(
    database.connect("./data/database.sqlite", 16, 60_000)
    |> result.map_error(fn(error) {
      io.println_error("Error connecting to database:")
      io.debug(error)
      Nil
    }),
  )

  let stop = fn() { database.disconnect(db, 2000) }

  use _ <- result.try(
    tailwind.delete_temporary_files()
    |> result.map_error(fn(error) {
      io.println_error("Error deleting temporary tailwind files:")
      io.debug(error)

      stop()
    }),
  )

  use secret_key_base <- result.try(
    database.connection(db, 100, fn(error) { error }, fn(connection) {
      secret_key_base(connection) |> result.map_error(database.SqlightError)
    })
    |> result.map_error(fn(error) {
      io.println_error("Error getting secret key base:")
      io.debug(error)

      stop()
    }),
  )

  process.start(
    fn() {
      use handler <- result.try(
        router.Configuration(db:, dev_mode: False, restart: fn(timeout: Int) {
          process.send_after(self, timeout, RestartServer)
        })
        |> router.handler,
      )

      case
        wisp_mist.handler(handler, secret_key_base)
        |> mist.new
        |> mist.bind("0.0.0.0")
        |> mist.port(8161)
        |> mist.start_http
        |> result.map_error(fn(error) {
          io.println_error("Error starting wisp server:")
          io.debug(error)
          Nil
        })
      {
        Ok(wisp_server) ->
          actor.send(self, WispPid(process.subject_owner(wisp_server))) |> Ok
        Error(Nil) -> actor.send(self, WispStartingFailed) |> Error
      }
    },
    False,
  )

  Server(db:, secret_key_base:, wisp_server: None) |> Ok
}

pub fn main() {
  let assert Ok(supervisor) =
    actor.start(State(self: None, server: None), update)

  actor.send(supervisor, Started(supervisor))
  actor.send(supervisor, StartServer)

  process.sleep_forever()
}

fn secret_key_base(db: database.Connection) -> Result(String, sqlight.Error) {
  db.stmts.config.get_or_set("general.secret_key_base", fn() {
    let secret_key_base = wisp.random_string(128)
    let now = birl.now() |> birl.to_unix_milli
    #(secret_key_base, now)
  })
  |> result.map(fn(config) { config.value })
}
