import backend/database.{type Db}
import backend/database/page_request
import backend/database/session
import backend/database/user
import backend/database/visitor_session
import backend/middleware/session.{type Session, Session} as middleware_session
import birl
import gleam/bit_array
import gleam/crypto
import gleam/http
import gleam/http/cookie
import gleam/http/request
import gleam/http/response

//import gleam/int
import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import wisp.{type Request, type Response}

const session_query_key = "session-id"

const session_cookie_name = "session-id"

/// 60 * 60 * 24 * 161
const session_lifetime_second = 13_910_400

pub type Handler =
  fn(Request, fn(Session) -> #(Response, Session)) -> Response

pub fn handler(db: Db, dev_mode: Bool) -> Handler {
  fn(req: Request, next: fn(Session) -> #(Response, Session)) -> Response {
    let session_id = case get_session_id(req) {
      Some(session_id) -> session_id
      None -> generate_session_id()
    }

    let user =
      database.connection(db, 1000, fn(e) { e }, fn(connection) {
        let now = birl.now() |> birl.to_unix_milli

        {
          use visitor <- result.try(
            visitor_session.get_by_session_key_or_insert_new(
              connection,
              session_id,
              now,
            ),
          )

          use _ <- result.try(page_request.insert_new(
            connection,
            visitor.visitor_id,
            req.path,
            now,
          ))

          use session <- result.try(session.get_by_key(
            connection,
            session_id,
            now,
          ))

          case session {
            Some(session) -> {
              use _ <- result.try(session.update(
                connection,
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

              user.get(connection, session.user_id)
            }
            None -> Ok(None)
          }
        }
        |> result.map_error(fn(error) { database.SqlightError(error) })
      })

    let user = case user {
      Ok(user) -> user
      Error(error) -> {
        io.debug(error)
        None
      }
    }

    let session = middleware_session.new(session_id, user)

    let #(response, new_session) = next(session)
    let new_session = Session(..new_session, id: session_id)

    response
    |> set_session_cookie(
      session_id,
      dev_mode,
      new_session.user |> option.is_some,
    )
  }
}

fn get_session_id(req: Request) -> Option(BitArray) {
  let values = list.flatten([wisp.get_query(req), request.get_cookies(req)])

  let session_id =
    list.find(values, fn(value) { value.0 == session_query_key })
    |> result.then(fn(value) { bit_array.base64_decode(value.1) })

  case session_id {
    Error(Nil) -> None
    Ok(session_id) -> Some(session_id)
  }
}

fn generate_session_id() -> BitArray {
  //let now = birl.now() |> birl.to_unix_micro |> int.to_string

  crypto.strong_random_bytes(224 / 8)
  //|> bit_array.append(<<now:utf8>>)
  //|> crypto.hash(crypto.Sha224, _)
}

fn set_session_cookie(
  response: Response,
  id: BitArray,
  dev_mode: Bool,
  permanent: Bool,
) -> Response {
  let cookie_attributes =
    cookie.Attributes(
      ..cookie.defaults(case dev_mode {
        False -> http.Https
        True -> http.Http
      }),
      max_age: case permanent {
        False -> None
        True -> option.Some(session_lifetime_second)
      },
      same_site: Some(cookie.Strict),
    )

  let cookie_value = bit_array.base64_encode(id, True)

  response.set_cookie(
    response,
    session_cookie_name,
    cookie_value,
    cookie_attributes,
  )
}
