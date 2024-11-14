import gleam/bit_array
import gleam/crypto
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

pub opaque type Middleware {
  Middleware(subject: Subject(Msg), session_id: String)
}

type Msg

type State {
  State
}

fn init() -> State {
  State
}

pub fn middleware(dev_mode: Bool) {
  use subject <- result.try(actor.start(init(), update))

  Ok(fn(req: Request, next: fn(Middleware) -> Response) -> Response {
    let session_id = case get_session_id(req) {
      Some(session_id) -> session_id
      None -> generate_session_id()
    }

    let cookie_attributes =
      cookie.Attributes(
        ..cookie.defaults(case dev_mode {
          False -> http.Https
          True -> http.Http
        }),
        max_age: option.Some(60 * 60 * 24 * 161),
        same_site: Some(cookie.Strict),
      )

    let cookie_value =
      wisp.sign_message(req, <<session_id:utf8>>, crypto.Sha512)

    next(Middleware(subject:, session_id:))
    |> response.set_cookie(session_cookie_name, cookie_value, cookie_attributes)
  })
}

fn update(msg: Msg, state: State) -> Next(Msg, State) {
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
