import backend/executable.{type Executable}
import backend/tailwind/tailwind.{
  type Either, type Environment, type TailwindError, Left, Right,
  destruct_environment, setup_environment,
}
import gleam/dict.{type Dict}
import gleam/erlang/process.{type Subject, type Timer}
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/otp/actor.{type Next, type StartError, Stop, continue}
import gleam/result
import gleam/string
import simplifile

const timeout = 600_000

const read_css_interval = 2500

@external(erlang, "backend_ffi", "unique_int")
fn unique_int() -> Int

type Msg {
  StartProcess(self: Subject(Msg), executable: Executable)
  MessageReceived(self: Subject(Msg), message: String)
  ExitReceived(Result(Int, String))
  SetHtml(key: String, html: String)
  RemoveHtml(key: String)
  GetStyle(reply_to: Subject(String))
  OnStyleChange(callback: fn(String) -> Nil)
  Close
  ReadCss(self: Subject(Msg))
}

type State {
  State(
    environment: Environment,
    executable: Option(Executable),
    css: Option(String),
    reply_to: List(Subject(String)),
    on_style_change: List(fn(String) -> Nil),
    html: Dict(String, Int),
    read_css_timer: Option(Timer),
  )
}

pub opaque type Tailwind {
  Tailwind(
    actor: Subject(Msg),
    environment: Environment,
    executable: Executable,
  )
}

fn init(environment: Environment) -> State {
  State(
    environment:,
    executable: None,
    css: None,
    reply_to: [],
    on_style_change: [],
    html: dict.new(),
    read_css_timer: None,
  )
}

fn update(msg: Msg, state: State) -> Next(Msg, State) {
  case msg {
    Close -> {
      case state.read_css_timer {
        Some(timer) -> {
          process.cancel_timer(timer)
          Nil
        }
        None -> Nil
      }
      case state.executable {
        Some(executable) -> executable.kill(executable)
        None -> Nil
      }
      case destruct_environment(state.environment) {
        Ok(Nil) -> Nil
        Error(error) -> {
          io.println_error("Error destructing environment:")
          io.debug(error)
          Nil
        }
      }
      Stop(process.Normal)
    }

    ExitReceived(exit) -> {
      case state.read_css_timer {
        Some(timer) -> {
          process.cancel_timer(timer)
          Nil
        }
        None -> Nil
      }
      case exit {
        Ok(exit_code) -> {
          io.println_error(
            "Tailwind CSS CLI exited with code " <> int.to_string(exit_code),
          )
        }
        Error(error) -> {
          io.println_error("Error running Tailwind CSS CLI:")
          io.println_error(error)
        }
      }
      case destruct_environment(state.environment) {
        Ok(Nil) -> Nil
        Error(error) -> {
          io.println_error("Error destructing environment:")
          io.debug(error)
          Nil
        }
      }
      Stop(process.Normal)
    }
    GetStyle(reply_to) -> {
      case state.executable {
        Some(executable) -> executable.timeout(executable, Some(timeout))
        None -> Nil
      }

      case state.css {
        Some(css) -> {
          process.send(reply_to, css)
          continue(state)
        }
        None -> continue(State(..state, reply_to: [reply_to, ..state.reply_to]))
      }
    }
    MessageReceived(self, msg) -> {
      case string.contains(msg, "Done") {
        True -> update(ReadCss(self:), state)
        False -> continue(state)
      }
    }
    OnStyleChange(callback) -> {
      case state.css {
        Some(css) -> callback(css)
        None -> Nil
      }
      continue(
        State(..state, on_style_change: [callback, ..state.on_style_change]),
      )
    }
    SetHtml(key, content) -> {
      case state.executable {
        Some(executable) -> executable.timeout(executable, Some(timeout))
        None -> Nil
      }

      let #(id, state) = case dict.get(state.html, key) {
        Ok(id) -> #(id, state)
        Error(Nil) -> {
          let id = unique_int()
          #(id, State(..state, html: dict.insert(state.html, key, id)))
        }
      }

      case
        simplifile.write(
          state.environment.temporary_path
            <> "/"
            <> int.to_string(id)
            <> ".html",
          content,
        )
      {
        Ok(_) -> Nil
        Error(error) -> {
          io.println_error("Error writing temporary file:")
          io.debug(error)
          Nil
        }
      }

      continue(state)
    }
    RemoveHtml(key) -> {
      case state.executable {
        Some(executable) -> executable.timeout(executable, Some(timeout))
        None -> Nil
      }
      case dict.get(state.html, key) {
        Ok(id) -> {
          case
            simplifile.delete(
              state.environment.temporary_path <> "/" <> int.to_string(id),
            )
          {
            Ok(_) -> Nil
            Error(error) -> {
              io.println_error("Error deleting temporary file:")
              io.debug(error)
              Nil
            }
          }
          continue(State(..state, html: dict.delete(state.html, key)))
        }
        Error(Nil) -> continue(state)
      }
    }
    StartProcess(self, executable) -> {
      let timer = process.send_after(self, timeout, ReadCss(self))
      continue(
        State(
          ..state,
          executable: Some(executable),
          read_css_timer: Some(timer),
        ),
      )
    }
    ReadCss(self) -> {
      case state.read_css_timer {
        Some(timer) -> {
          process.cancel_timer(timer)
          Nil
        }
        None -> Nil
      }

      let state = case simplifile.read(state.environment.css_output_path) {
        Ok(css) -> {
          list.map(state.reply_to, fn(reply_to) { process.send(reply_to, css) })
          let changed = case state.css {
            Some(existing_css) -> css != existing_css
            None -> True
          }

          case changed {
            True -> {
              list.map(state.on_style_change, fn(callback) { callback(css) })
              Nil
            }
            False -> Nil
          }

          State(..state, css: Some(css), reply_to: [])
        }
        Error(error) -> {
          io.println_error("Error reading CSS file:")
          io.debug(error)
          state
        }
      }

      let timer = process.send_after(self, read_css_interval, ReadCss(self))
      continue(State(..state, read_css_timer: Some(timer)))
    }
  }
}

pub fn new() -> Result(Tailwind, Either(TailwindError, StartError)) {
  use environment_constructor <- result.try(
    setup_environment() |> result.map_error(Left),
  )

  use environment <- result.try(
    environment_constructor()
    |> result.map_error(Left),
  )

  use actor <- result.try(
    actor.start(init(environment), update)
    |> result.map_error(Right),
  )

  let executable =
    executable.spawn(
      environment.temporary_path,
      environment.tailwind_css_cli_path,
      [
        "--config",
        environment.tailwind_css_config_path,
        "--output",
        environment.css_output_path,
        "--watch",
      ],
      fn(message) { process.send(actor, MessageReceived(actor, message)) },
      fn(exit) { process.send(actor, ExitReceived(exit)) },
      Some(timeout),
    )

  process.send(actor, StartProcess(self: actor, executable:))

  Tailwind(actor:, environment:, executable:)
  |> Ok
}

pub fn running(tailwind: Tailwind) -> Bool {
  process.is_alive(process.subject_owner(tailwind.actor))
}

pub fn close(tailwind: Tailwind) -> Bool {
  case running(tailwind) {
    True -> {
      process.send(tailwind.actor, Close)
      True
    }
    False -> False
  }
}

pub fn set_html(tailwind: Tailwind, key: String, html: String) -> Bool {
  case running(tailwind) {
    True -> {
      process.send(tailwind.actor, SetHtml(key, html))
      True
    }
    False -> False
  }
}

pub fn remove_html(tailwind: Tailwind, key: String) -> Bool {
  case running(tailwind) {
    True -> {
      process.send(tailwind.actor, RemoveHtml(key))
      True
    }
    False -> False
  }
}

pub fn get_style(tailwind: Tailwind) -> Result(String, Nil) {
  case running(tailwind) {
    True -> {
      process.call_forever(tailwind.actor, fn(reply_to) { GetStyle(reply_to) })
      |> Ok
    }
    False -> Error(Nil)
  }
}

pub fn on_style_change(tailwind: Tailwind, callback: fn(String) -> Nil) -> Bool {
  case running(tailwind) {
    True -> {
      process.send(tailwind.actor, OnStyleChange(callback))
      True
    }
    False -> False
  }
}
