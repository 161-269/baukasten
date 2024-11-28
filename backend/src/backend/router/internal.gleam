import backend/database.{type Db}
import backend/middleware
import backend/middleware/session.{type Session}
import backend/page/internal/login
import backend/tailwind
import birl
import gleam/http.{Get, Post}
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string
import gleam/string_tree
import wisp.{type Request, type Response}

fn login(
  db: Db,
) -> Result(fn(Request, Session) -> Response, tailwind.TailwindError) {
  use #(style, login_page) <- result.try(login.page("", "@Baukasten 🛠️"))

  fn(req: Request, session: Session) {
    use <-
      fn(next) {
        case string.ends_with(req.path, ".css") {
          True ->
            wisp.response(200)
            |> wisp.set_header("content-type", "text/css; charset=utf-8")
            |> wisp.set_body(wisp.Text(string_tree.from_string(style)))
          False -> next()
        }
      }

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
            use conn <- database.connection(db, 1000, fn(_) {
              "Could not get database connection"
            })
            use user <- result.try(
              conn.stmts.user.search_and_verify(username, password)
              |> result.map_error(fn(_) { "Username or password is incorrect" }),
            )

            let now = birl.now() |> birl.to_unix_milli

            use _ <- result.try(
              conn.stmts.session.insert_new(
                session.id(session),
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
              |> result.map_error(fn(_) { "Could not create session" }),
            )

            Ok(user)
          }
        }
      }
    }

    case result {
      Error(error) -> login_page(req.path, error)
      Ok(user) -> {
        session.set_user(session, Some(user))
        wisp.redirect("/_")
      }
    }
  }
  |> Ok
}

pub fn route(
  db: Db,
) -> Result(
  fn(Request, List(String), Session) -> Response,
  tailwind.TailwindError,
) {
  use login <- result.try(login(db))

  fn(req: Request, path: List(String), session: Session) {
    case path {
      ["login"] | ["login.css"] ->
        case session.authenticated(session) {
          True -> wisp.redirect("/_")
          False -> login(req, session)
        }
      _ -> {
        use _user <- session.require_authentication(session)

        case path {
          _ -> wisp.not_found()
        }
      }
    }
  }
  |> Ok
}
