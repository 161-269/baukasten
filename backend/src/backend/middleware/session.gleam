import gleam/http/response.{Response as HttpResponse}
import wisp.{type Response}

pub type Session {
  Session(id: String, authenticated: Bool)
}

pub fn new_session(id: String) {
  Session(id:, authenticated: False)
}

pub fn require_authentication(
  session: Session,
  next: fn() -> Response,
) -> Response {
  case session.authenticated {
    True -> next()
    False -> HttpResponse(..wisp.redirect("/login"), status: 403)
  }
}
