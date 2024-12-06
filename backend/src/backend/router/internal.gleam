import backend/database.{type Db}
import backend/middleware
import backend/middleware/session.{type Session}
import backend/page/internal/login
import backend/tailwind.{type Tailwind}
import birl
import gleam/http.{Get, Post}
import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string
import wisp.{type Request, type Response}

fn login(db: Db, tailwind: Tailwind) -> fn(Request, Session) -> Response {
  let login_page = login.page(tailwind, "", "@Baukasten 🛠️")
  fn(req: Request, sn: Session) {
    use form: Option(wisp.FormData) <-
      fn(next) {
        case req.method {
          Get -> next(None)
          Post -> {
            use form <- wisp.require_form(req)
            next(Some(form))
          }
          _ -> wisp.method_not_allowed([Get, Post])
        }
      }

    let result = case form {
      None -> Error("")
      Some(form) -> {
        let username =
          list.find_map(form.values, fn(value) {
            case value.0 == "username" {
              True -> Ok(value.1)
              False -> Error(Nil)
            }
          })
          |> result.unwrap("")
          |> string.trim
        let password =
          list.find_map(form.values, fn(value) {
            case value.0 == "password" {
              True -> Ok(value.1)
              False -> Error(Nil)
            }
          })
          |> result.unwrap("")

        case username, password {
          "", _ | _, "" -> Error("")
          username, password -> {
            use conn <- database.connection(db, 1000, fn(error) {
              io.println_error("Error getting database connection:")
              io.debug(error)
              "Could not get database connection"
            })
            use user <- result.try(
              conn.stmts.user.search_and_verify(username, password)
              |> result.map_error(fn(error) {
                io.println_error("Error searching user:")
                io.debug(error)
                "Username or password is incorrect"
              }),
            )

            let now = birl.now() |> birl.to_unix_milli

            use _ <- result.try(
              conn.stmts.session.insert_new_or_update(
                session.id(sn),
                user.id,
                middleware.session_lifetime_second * 1000,
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
              )
              |> result.map_error(fn(error) {
                io.println_error("Error creating session:")
                io.debug(error)
                "Could not create session"
              }),
            )

            Ok(user)
          }
        }
      }
    }

    case result {
      Error(error) -> login_page(req.path, error)
      Ok(user) -> {
        session.set_user(sn, Some(user))
        wisp.redirect("/_")
      }
    }
  }
}

fn logout(db: Db, req: Request, sn: Session) -> Response {
  case
    {
      case session.authenticated(sn) {
        False -> Ok(Nil)
        True -> {
          use conn <- database.connection(db, 1000, fn(error) {
            io.println_error("Error getting database connection:")
            io.debug(error)
            "Could not get database connection"
          })
          let now = birl.now() |> birl.to_unix_milli

          use _ <- result.try(
            conn.stmts.session.update_by_key(
              session.id(sn),
              Some(0),
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
            )
            |> result.map_error(fn(error) {
              io.println_error("Error updating session:")
              io.debug(error)
              "Could not update session"
            }),
          )

          session.set_user(sn, None)
          Ok(Nil)
        }
      }
    }
  {
    Ok(_) -> wisp.redirect("/")
    Error(_) -> {
      wisp.internal_server_error()
    }
  }
}

pub fn route(
  db: Db,
  tailwind: Tailwind,
) -> fn(Request, List(String), Session) -> Response {
  let login = login(db, tailwind)

  fn(req: Request, path: List(String), session: Session) {
    case path {
      ["login"] | ["login.css"] ->
        case session.authenticated(session) {
          True -> wisp.redirect("/_")
          False -> login(req, session)
        }
      ["logout"] -> logout(db, req, session)
      _ -> {
        use _user <- session.require_authentication(session)

        case path {
          _ -> wisp.not_found()
        }
      }
    }
  }
}
