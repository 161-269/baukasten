import backend/database.{type Db}
import backend/middleware/page_request
import backend/middleware/session.{type Session} as middleware_session
import backend/page/error
import birl
import exception
import gleam/bit_array
import gleam/crypto
import gleam/http
import gleam/http/cookie
import gleam/http/request
import gleam/http/response
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string
import wisp.{type Request, type Response}

const session_query_cookie_key = "session-id"

const user_authenticated_cookie_key = "authenticated"

/// 60 * 60 * 24 * 161
const session_lifetime_second = 13_910_400

pub type Handler =
  fn(Request, fn(Session, List(String)) -> Response) -> Response

pub fn handler(db: Db, dev_mode: Bool) -> Result(Handler, Nil) {
  use page_request <- result.try(page_request.new(db, 5000))

  Ok(fn(req: Request, next: fn(Session, List(String)) -> Response) -> Response {
    use <- wisp.rescue_crashes

    use <-
      fn(next) {
        case dev_mode {
          True -> {
            wisp.configure_logger()

            case exception.rescue(next) {
              Ok(value) -> value
              Error(error) -> {
                io.println_error("Error handling request:")
                io.debug(error)
                error.internal_sever_error(db)
              }
            }
          }
          False -> next()
        }
      }

    let req = wisp.method_override(req)
    use req <- wisp.handle_head(req)

    let #(session_id, should_be_authenticated) = case get_session_id(req) {
      Some(#(session_id, authenticated)) -> #(session_id, authenticated)
      None -> #(generate_session_id(), False)
    }

    let now = birl.now() |> birl.to_unix_milli
    page_request.log(page_request, now, session_id, req.path)

    let user = case should_be_authenticated {
      True -> {
        let user =
          database.connection(db, 1000, fn(e) { e }, fn(connection) {
            {
              use session <- result.try(connection.stmts.session.get_by_key(
                session_id,
                now,
              ))

              case session {
                Some(session) -> {
                  use _ <- result.try(connection.stmts.session.update(
                    session,
                    Some(session_lifetime_second * 1000),
                    case
                      list.find(req.headers, fn(header) {
                        let #(key, _) = header
                        key == "user-agent"
                      })
                    {
                      Error(_) -> None
                      Ok(#(_, value)) -> Some(value)
                    },
                    now,
                  ))

                  connection.stmts.user.get(session.user_id)
                }
                None -> Ok(None)
              }
            }
            |> result.map_error(fn(error) { database.SqlightError(error) })
          })

        case user {
          Ok(user) -> user
          Error(error) -> {
            io.debug(error)
            None
          }
        }
      }
      False -> None
    }

    use session <- middleware_session.new(session_id, user, fn(error) {
      io.println_error("Error creating session:")
      io.debug(error)
      error.internal_sever_error(db)
    })

    let segments = path_segments(req)
    let response = next(session, segments)
    let user = middleware_session.user(session)

    response
    |> set_session_cookie(req, session_id, dev_mode, user |> option.is_some)
    |> error.handle(db)
  })
}

fn get_session_id(req: Request) -> Option(#(BitArray, Bool)) {
  let query = wisp.get_query(req)
  let cookies = request.get_cookies(req)

  let find = fn(values: List(#(String, String))) {
    list.find(values, fn(value) { value.0 == session_query_cookie_key })
    |> result.then(fn(value) { wisp.verify_signed_message(req, value.1) })
  }

  let query_session_id = find(query)
  let session_id = case query_session_id {
    Ok(session_id) -> Ok(session_id)
    Error(Nil) -> find(cookies)
  }

  case session_id {
    Error(Nil) -> None
    Ok(session_id) ->
      Some(#(
        session_id,
        result.is_ok(query_session_id)
          || list.find(cookies, fn(cookie) {
          cookie.0 == user_authenticated_cookie_key && cookie.1 == "161"
        })
        |> result.is_ok,
      ))
  }
}

fn generate_session_id() -> BitArray {
  let now = birl.now() |> birl.to_unix_micro |> int.to_string

  crypto.strong_random_bytes(224 / 8)
  |> bit_array.append(<<now:utf8>>)
  |> crypto.hash(crypto.Sha224, _)
}

fn path_segments(req: Request) -> List(String) {
  wisp.path_segments(req)
  |> list.map(fn(segment) { string.trim(segment) })
  |> list.filter(fn(segment) { segment != "" })
  |> list.map(fn(segment) { string.lowercase(segment) })
}

fn set_session_cookie(
  response: Response,
  req: Request,
  id: BitArray,
  dev_mode: Bool,
  authenticated: Bool,
) -> Response {
  let cookie_attributes =
    cookie.Attributes(
      ..cookie.defaults(case dev_mode {
        False -> http.Https
        True -> http.Http
      }),
      max_age: case authenticated {
        False -> None
        True -> option.Some(session_lifetime_second)
      },
      same_site: Some(cookie.Strict),
    )

  let cookie_value = wisp.sign_message(req, id, crypto.Sha224)
  response.set_cookie(
    response,
    session_query_cookie_key,
    cookie_value,
    cookie_attributes,
  )

  response.set_cookie(
    response,
    user_authenticated_cookie_key,
    case authenticated {
      True -> "161"
      False -> "0"
    },
    cookie_attributes,
  )
}
