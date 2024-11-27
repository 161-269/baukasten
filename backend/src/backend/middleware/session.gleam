import backend/database/user.{type User}
import exception
import gleam/erlang/process.{type Subject}
import gleam/http/response.{Response as HttpResponse}
import gleam/option.{type Option, None, Some}
import gleam/otp/actor.{type Next, continue}
import wisp.{type Response}

pub opaque type Session {
  Session(actor: Subject(Msg))
}

type State {
  State(id: BitArray, user: Option(User))
}

type Msg {
  SetUser(Option(User))
  CurrentState(reply_to: Subject(State))
  Close
}

fn update(msg: Msg, state: State) -> Next(Msg, State) {
  case msg {
    SetUser(user) -> continue(State(..state, user: user))
    CurrentState(reply_to) -> {
      process.send(reply_to, state)
      actor.Continue(state, None)
    }
    Close -> actor.Stop(process.Normal)
  }
}

pub fn new(
  id: BitArray,
  user: Option(User),
  on_error: fn(actor.StartError) -> a,
  next: fn(Session) -> a,
) -> a {
  let state = State(id:, user:)
  use actor <-
    fn(next) {
      case actor.start(state, update) {
        Ok(actor) -> next(actor)
        Error(error) -> on_error(error)
      }
    }
  use <- exception.defer(fn() { process.send(actor, Close) })

  next(Session(actor: actor))
}

pub fn user(session: Session) -> Option(User) {
  process.call_forever(session.actor, CurrentState).user
}

pub fn set_user(session: Session, user: Option(User)) {
  process.send(session.actor, SetUser(user))
}

pub fn require_authentication(
  session: Session,
  next: fn(User) -> Response,
) -> Response {
  case user(session) {
    Some(user) -> next(user)
    None -> HttpResponse(..wisp.redirect("/_/login"), status: 403)
  }
}
