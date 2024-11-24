import backend/database.{type Db}
import backend/database/user.{type User}
import backend/middleware
import backend/middleware/session.{type Session}
import backend/page/default
import birl
import gleam/bit_array
import gleam/crypto
import gleam/int
import gleam/option.{None, Some}
import gleam/result
import wisp.{type Request, type Response}

pub type Configuration {
  Configuration(db: Db, dev_mode: Bool, restart: fn() -> Nil)
}

pub fn handler(cfg: Configuration) -> Result(fn(Request) -> Response, Nil) {
  use <- setup_check(cfg)
  use middleware <- result.try(middleware.handler(cfg.db, cfg.dev_mode))
  let default_page = default.page()

  fn(req: Request) -> Response {
    use session, path <- middleware(req)

    case path {
      ["maintenance", ..rest] ->
        case rest {
          ["login"] -> {
            case session.user {
              Some(_) -> #(wisp.redirect("/maintenance"), session)
              None -> #(wisp.not_found(), session)
            }
          }
          _ -> {
            use user <- session.require_authentication(session)

            maintenance(req, path, session, user, cfg.db)
          }
        }
      _ -> #(default_page(req), session)
    }
  }
  |> Ok
}

fn maintenance(
  req: Request,
  path: List(String),
  session: Session,
  user: User,
  db: Db,
) -> #(Response, Session) {
  #(wisp.not_found(), session)
}

fn setup_check(
  cfg: Configuration,
  next: fn() -> Result(fn(Request) -> Response, Nil),
) -> Result(fn(Request) -> Response, Nil) {
  use user_count <- result.try({
    use conn <- database.connection(cfg.db, 1000, fn(_) { Nil })

    conn.stmts.user.count() |> result.map_error(fn(_) { Nil })
  })

  use <-
    fn(setup) {
      case user_count {
        0 -> setup()
        _ -> next()
      }
    }

  use initial_password <- result.try({
    use conn <- database.connection(cfg.db, 1000, fn(_) { Nil })
    {
      use <- conn.stmts.config.get_or_set("general.setup_password")
      let now = birl.now() |> birl.to_unix_micro

      let value =
        crypto.strong_random_bytes(224 / 8)
        |> bit_array.append(<<int.to_string(now):utf8>>)
        |> crypto.hash(crypto.Sha224, _)
        |> bit_array.base64_url_encode(True)

      #(value, now)
    }
    |> result.map_error(fn(_) { Nil })
  })

  let default_page = default.page()

  fn(req: Request) -> Response { default_page(req) } |> Ok
}
