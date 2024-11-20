import backend/database/user.{type User}
import gleam/http/response.{Response as HttpResponse}
import gleam/option.{type Option, None, Some}
import wisp.{type Response}

pub type Session {
  Session(id: BitArray, user: Option(User))
}

pub fn new(id: BitArray, user: Option(User)) {
  Session(id:, user:)
}

pub fn require_authentication(
  session: Session,
  next: fn(User) -> Response,
) -> Response {
  case session.user {
    Some(user) -> next(user)
    None -> HttpResponse(..wisp.redirect("/maintenance/login"), status: 403)
  }
}
