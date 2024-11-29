import backend/tailwind.{type TailwindError}
import gleam/erlang/process.{type Subject, type Timer}
import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/otp/actor.{type Next, Stop, continue}
import gleam/otp/task.{type Task}
import gleam/result

pub opaque type Tailwind {
  Tailwind(actor: Subject(Msg))
}

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

type State {
  State(
    css: Option(String),
    html: List(String),
    waiting: List(Subject(String)),
    next_waiting: List(Subject(String)),
    validity: Validity,
    timer: Option(Timer),
    compilation: Option(Task(Result(String, TailwindError))),
  )
}

fn init() -> State {
  State(
    css: None,
    html: [],
    waiting: [],
    next_waiting: [],
    validity: Invalid,
    timer: None,
    compilation: None,
  )
}

fn compile(
  self: Subject(Msg),
  html: List(String),
) -> Task(Result(String, TailwindError)) {
  task.async(fn() {
    let result = tailwind.generate_css_for()(html)
    process.send(self, CompilationDone(self, result))
    result
  })
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
      let compilation = compile(self, state.html)

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
        Some(compilation) -> process.kill(task.pid(compilation))
        None -> Nil
      }
      Stop(process.Normal)
    }
  }
}

pub fn new() -> Result(Tailwind, actor.StartError) {
  use actor <- result.try(actor.start(init(), update))

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
