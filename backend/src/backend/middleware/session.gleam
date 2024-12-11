import backend/database.{type Db}
import backend/database/user.{type User}
import backend/tailwind/build.{type Tailwind}
import exception
import gleam/erlang/process.{type Subject}
import gleam/http/response.{Response as HttpResponse}
import gleam/option.{type Option, None, Some}
import gleam/otp/actor.{type Next, continue}
import wisp.{type Response}

pub opaque type Session {
  Session(db: Db, tailwind: Tailwind, id: BitArray, actor: Subject(Msg))
}

type State {
  State(user: Option(User))
}

type Msg {
  SetUser(Option(User))
  CurrentState(reply_to: Subject(State))
  Close
}

fn update(msg: Msg, state: State) -> Next(Msg, State) {
  case msg {
    SetUser(user) -> continue(State(user: user))
    CurrentState(reply_to) -> {
      process.send(reply_to, state)
      actor.Continue(state, None)
    }
    Close -> actor.Stop(process.Normal)
  }
}

pub fn new(
  db: Db,
  tailwind: Tailwind,
  id: BitArray,
  user: Option(User),
  on_error: fn(actor.StartError) -> a,
  next: fn(Session) -> a,
) -> a {
  let state = State(user:)
  use actor <-
    fn(next) {
      case actor.start(state, update) {
        Ok(actor) -> next(actor)
        Error(error) -> on_error(error)
      }
    }
  use <- exception.defer(fn() { process.send(actor, Close) })

  next(Session(db: db, tailwind: tailwind, id:, actor: actor))
}

pub fn user(session: Session) -> Option(User) {
  process.call_forever(session.actor, CurrentState).user
}

pub fn db(session: Session) -> Db {
  session.db
}

pub fn tailwind(session: Session) -> Tailwind {
  session.tailwind
}

pub fn id(session: Session) -> BitArray {
  session.id
}

pub fn set_user(session: Session, user: Option(User)) {
  process.send(session.actor, SetUser(user))
}

pub fn authenticated(session: Session) -> Bool {
  case user(session) {
    Some(_) -> True
    None -> False
  }
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
