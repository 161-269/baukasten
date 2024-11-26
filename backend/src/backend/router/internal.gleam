import backend/database.{type Db}
import backend/middleware/session.{type Session}
import gleam/http.{Get, Post}
import gleam/option.{None, Some}
import wisp.{type Request, type Response}

pub fn login(req: Request, _session: Session, _db: Db) -> Response {
  use _form <-
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

  wisp.not_found()
}

pub fn route(
  req: Request,
  path: List(String),
  session: Session,
  db: Db,
) -> Response {
  case path {
    ["login"] -> login(req, session, db)
    _ -> {
      use _user <- session.require_authentication(session)

      case path {
        _ -> wisp.not_found()
      }
    }
  }
}
