import gleam/bit_array
import gleam/crypto
import gleam/dict.{type Dict}
import gleam/erlang/process.{type Subject}
import gleam/http
import gleam/http/cookie
import gleam/http/response
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/otp/actor.{type Next}
import gleam/result
import wisp.{type Request, type Response}

const session_query_key = "session-id"

const session_cookie_name = "session-id"

type Msg {
  UpdateSession(session: Session)
  GetSession(id: String, reply_to: Subject(Option(Session)))
}

type State {
  State(sessions: Dict(String, Session))
}

pub type Session {
  Session(id: String)
}

fn init() -> State {
  State(sessions: dict.new())
}

fn new_session(id: String) {
  Session(id:)
}

pub fn middleware(dev_mode: Bool) {
  use subject <- result.try(actor.start(init(), update))

  Ok(fn(req: Request, next: fn(Session) -> #(Response, Session)) -> Response {
    let session_id = case get_session_id(req) {
      Some(session_id) -> session_id
      None -> generate_session_id()
    }

    let session = case process.call(subject, GetSession(session_id, _), 100) {
      Some(session) -> session
      None -> new_session(session_id)
    }

    let #(response, new_session) = next(session)

    process.send(subject, UpdateSession(new_session))

    response
    |> set_session_cookie(req, session_id, dev_mode)
  })
}

fn update(msg: Msg, state: State) -> Next(Msg, State) {
  let state = case msg {
    UpdateSession(session) ->
      State(sessions: dict.insert(state.sessions, session.id, session))
    GetSession(id, reply_to) -> {
      let session =
        dict.get(state.sessions, id)
        |> option.from_result

      process.send(reply_to, session)

      state
    }
  }

  actor.Continue(state, None)
}

fn get_session_id(req: Request) -> Option(String) {
  let queries = wisp.get_query(req)

  let session_id =
    list.find(queries, fn(query) { query.0 == session_query_key })

  case session_id {
    Ok(query) -> Some(query.1)
    Error(Nil) -> {
      case wisp.get_cookie(req, session_cookie_name, wisp.Signed) {
        Ok(id) -> Some(id)
        Error(Nil) -> None
      }
    }
  }
}

fn generate_session_id() -> String {
  crypto.strong_random_bytes(512 / 8)
  |> crypto.hash(crypto.Sha512, _)
  |> bit_array.base64_url_encode(False)
}

fn set_session_cookie(
  response: Response,
  request: Request,
  id: String,
  dev_mode: Bool,
) -> Response {
  let cookie_attributes =
    cookie.Attributes(
      ..cookie.defaults(case dev_mode {
        False -> http.Https
        True -> http.Http
      }),
      max_age: option.Some(60 * 60 * 24 * 161),
      same_site: Some(cookie.Strict),
    )

  let cookie_value = wisp.sign_message(request, <<id:utf8>>, crypto.Sha512)

  response.set_cookie(
    response,
    session_cookie_name,
    cookie_value,
    cookie_attributes,
  )
}
