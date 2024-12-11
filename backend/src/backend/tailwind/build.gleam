import backend/executable
import backend/tailwind/tailwind.{
  type Either, type Environment, type EnvironmentConstructor, type TailwindError,
  CanNotReadCssOutputFile, CanNotWriteHtmlFile, Left, Right,
  TailwindCssCliErrorCode, TailwindCssCliErrorMessage, destruct_environment,
  setup_environment,
}
import gleam/erlang/process.{type Pid, type Subject, type Timer}
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/otp/actor.{type Next, type StartError, Stop, continue}
import gleam/result
import simplifile

type Msg {
  AddHtml(self: Subject(Msg), html: String)
  GetStyle(self: Subject(Msg), reply_to: Subject(String))
  CompileAfter(self: Subject(Msg), timeout: Int)
  Compile(self: Subject(Msg))
  CompilationDone(self: Subject(Msg), result: Result(String, TailwindError))
  Close
}

type Validity {
  Valid(css: String)
  Invalid
  Compiling
  CompilingInvalid
}

fn init(environment_constructor: EnvironmentConstructor) -> State {
  State(
    environment_constructor: environment_constructor,
    css: None,
    html: [],
    waiting: [],
    next_waiting: [],
    validity: Invalid,
    timer: None,
    compilation: None,
  )
}

type GeneratorMsg {
  SetupEnvironment(self: Subject(GeneratorMsg))
  DestructEnvironment(
    environment: Environment,
    result: Result(String, TailwindError),
  )
}

type GeneratorState {
  GeneratorState(
    parent: Subject(Msg),
    html: List(String),
    environment_constructor: EnvironmentConstructor,
  )
}

fn update_generator(
  msg: GeneratorMsg,
  state: GeneratorState,
) -> Next(GeneratorMsg, GeneratorState) {
  case msg {
    SetupEnvironment(self) -> {
      case state.environment_constructor() {
        Ok(environment) -> {
          let result = {
            let #(html, _) =
              list.fold(state.html, #([], 0), fn(acc, html) {
                let #(acc, index) = acc
                #([#(index, html), ..acc], index + 1)
              })

            use _ <- result.try(
              list.try_each(html, fn(html) {
                let #(index, html) = html
                simplifile.write(
                  environment.temporary_path
                    <> "/"
                    <> int.to_string(index)
                    <> ".html",
                  html,
                )
              })
              |> result.map_error(CanNotWriteHtmlFile),
            )
            let args = [
              "--config",
              environment.tailwind_css_config_path,
              "--output",
              environment.css_output_path,
              "--minify",
            ]

            executable.spawn(
              environment.temporary_path,
              environment.tailwind_css_cli_path,
              args,
              io.print,
              fn(exit_message) {
                let result = case exit_message {
                  Ok(exit_code) -> {
                    io.println(
                      "\nTailwindCSS exited with code: "
                      <> int.to_string(exit_code),
                    )

                    {
                      use _ <- result.try(case exit_code {
                        0 -> Ok(Nil)
                        _ -> Error(TailwindCssCliErrorCode(exit_code))
                      })

                      use css <- result.try(
                        simplifile.read(environment.css_output_path)
                        |> result.map_error(CanNotReadCssOutputFile),
                      )

                      Ok(css)
                    }
                  }
                  Error(error) -> {
                    io.println("\nTailwindCSS exited with error: " <> error)

                    Error(TailwindCssCliErrorMessage(error))
                  }
                }

                process.send(self, DestructEnvironment(environment, result))
              },
              Some(60_000),
            )

            Ok(Nil)
          }

          case result {
            Ok(Nil) -> continue(state)
            Error(error) ->
              update_generator(
                DestructEnvironment(environment, Error(error)),
                state,
              )
          }
        }
        Error(error) -> {
          process.send(
            state.parent,
            CompilationDone(state.parent, Error(error)),
          )
          Stop(process.Normal)
        }
      }
    }
    DestructEnvironment(environment, result) -> {
      let result = case result, destruct_environment(environment) {
        Ok(css), Ok(Nil) -> Ok(css)
        Ok(_), Error(error) -> Error(error)
        Error(error), _ -> Error(error)
      }

      process.send(state.parent, CompilationDone(state.parent, result))
      Stop(process.Normal)
    }
  }
}

fn compile(
  self: Subject(Msg),
  html: List(String),
  environment_constructor: EnvironmentConstructor,
) -> Result(Pid, StartError) {
  use task <- result.try(actor.start(
    GeneratorState(parent: self, html:, environment_constructor:),
    update_generator,
  ))

  process.send(task, SetupEnvironment(task))
  Ok(process.subject_owner(task))
}

fn update(msg: Msg, state: State) -> Next(Msg, State) {
  case msg {
    AddHtml(self, html) ->
      update(
        CompileAfter(self, 250),
        State(
          ..state,
          html: [html, ..state.html],
          validity: case state.validity {
            Compiling -> CompilingInvalid
            CompilingInvalid -> CompilingInvalid
            Invalid -> Invalid
            Valid(_) -> Invalid
          },
        ),
      )

    CompileAfter(self, timeout) ->
      continue(
        State(
          ..state,
          timer: case state.timer, state.validity {
            Some(timer), _ -> Some(timer)
            None, Valid(_) | None, Invalid ->
              Some(process.send_after(self, timeout, Compile(self)))
            None, Compiling | None, CompilingInvalid -> None
          },
        ),
      )

    Compile(self) -> {
      case compile(self, state.html, state.environment_constructor) {
        Ok(compilation) ->
          continue(
            State(
              ..state,
              validity: Compiling,
              timer: case state.timer {
                Some(timer) -> {
                  process.cancel_timer(timer)
                  None
                }
                None -> None
              },
              compilation: Some(compilation),
              waiting: list.flatten([state.waiting, state.next_waiting]),
              next_waiting: [],
            ),
          )
        Error(error) -> {
          io.println_error("Could not start compilation:")
          io.debug(error)
          update(
            CompileAfter(self, 250),
            State(
              ..state,
              validity: Invalid,
              timer: case state.timer {
                Some(timer) -> {
                  process.cancel_timer(timer)
                  None
                }
                None -> None
              },
            ),
          )
        }
      }
    }

    CompilationDone(self, result) ->
      case result {
        Ok(css) -> {
          list.map(state.waiting, fn(waiting) { process.send(waiting, css) })
          let state =
            State(
              ..state,
              compilation: None,
              css: Some(css),
              waiting: state.next_waiting,
              next_waiting: [],
              validity: case state.next_waiting {
                [] -> state.validity
                _ -> CompilingInvalid
              },
            )

          case state.validity {
            Valid(_) | Invalid | Compiling ->
              continue(State(..state, validity: Valid(css)))
            CompilingInvalid -> update(Compile(self), state)
          }
        }
        Error(error) -> {
          io.println_error("Could not compile TailwindCSS:")
          io.debug(error)
          update(CompileAfter(self, 250), State(..state, validity: Invalid))
        }
      }

    GetStyle(self, reply_to) ->
      case state.validity {
        Valid(css) -> {
          process.send(reply_to, css)
          continue(state)
        }
        Invalid ->
          update(
            Compile(self),
            State(..state, waiting: [reply_to, ..state.waiting]),
          )
        Compiling ->
          continue(State(..state, waiting: [reply_to, ..state.waiting]))
        CompilingInvalid ->
          continue(
            State(..state, next_waiting: [reply_to, ..state.next_waiting]),
          )
      }

    Close -> {
      case state.timer {
        Some(timer) -> {
          process.cancel_timer(timer)
          Nil
        }
        None -> Nil
      }
      case state.compilation {
        Some(compilation) -> process.kill(compilation)
        None -> Nil
      }
      Stop(process.Normal)
    }
  }
}

type State {
  State(
    environment_constructor: EnvironmentConstructor,
    css: Option(String),
    html: List(String),
    waiting: List(Subject(String)),
    next_waiting: List(Subject(String)),
    validity: Validity,
    timer: Option(Timer),
    compilation: Option(Pid),
  )
}

pub opaque type Tailwind {
  Tailwind(actor: Subject(Msg))
}

pub fn new() -> Result(Tailwind, Either(TailwindError, StartError)) {
  use environment_constructor <- result.try(
    setup_environment() |> result.map_error(Left),
  )
  use actor <- result.try(
    actor.start(init(environment_constructor), update)
    |> result.map_error(Right),
  )

  Tailwind(actor:)
  |> Ok
}

pub fn close(tailwind: Tailwind) {
  process.send(tailwind.actor, Close)
}

pub fn add_html(tailwind: Tailwind, html: String) {
  process.send(tailwind.actor, AddHtml(self: tailwind.actor, html:))
}

pub fn get_style(tailwind: Tailwind) -> String {
  process.call_forever(tailwind.actor, fn(reply_to) {
    GetStyle(self: tailwind.actor, reply_to:)
  })
}
