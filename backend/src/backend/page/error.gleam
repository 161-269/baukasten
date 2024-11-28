import backend/database.{type Db}
import gleam/http/response.{
  type Response as HttpResponse, Response as HttpResponse,
}
import gleam/list
import gleam/string_tree
import wisp.{type Response, Empty}

pub fn bad_request(db: Db) -> Response {
  wisp.bad_request()
  |> make_bad_request(db)
}

pub fn make_bad_request(resp: Response, _db: Db) -> Response {
  HttpResponse(..resp, status: 400)
  |> handle_redirection
}

pub fn forbidden(db: Db) -> Response {
  HttpResponse(403, [], Empty)
  |> make_forbidden(db)
}

pub fn make_forbidden(resp: Response, _db: Db) -> Response {
  HttpResponse(..resp, status: 403)
  |> handle_redirection
}

pub fn not_found(db: Db) -> Response {
  wisp.not_found()
  |> make_not_found(db)
}

pub fn make_not_found(resp: Response, _db: Db) -> Response {
  HttpResponse(..resp, status: 404)
  |> handle_redirection
}

pub fn internal_sever_error(db: Db) -> Response {
  wisp.internal_server_error()
  |> make_internal_server_error(db)
}

pub fn make_internal_server_error(resp: Response, _db: Db) -> Response {
  HttpResponse(..resp, status: 500)
  |> handle_redirection
}

pub fn handle(resp: Response, db: Db) -> Response {
  case resp {
    HttpResponse(400, _, Empty) -> make_bad_request(resp, db)
    HttpResponse(403, _, Empty) -> make_forbidden(resp, db)
    HttpResponse(404, _, Empty) -> make_not_found(resp, db)
    HttpResponse(500, _, Empty) -> make_internal_server_error(resp, db)
    _ -> resp
  }
}

fn handle_redirection(resp: Response) -> Response {
  let location = list.find(resp.headers, fn(header) { header.0 == "location" })

  case location {
    Error(_) -> resp
    Ok(#(_, value)) ->
      HttpResponse(
        ..resp,
        body: wisp.Text(
          string_tree.new()
          |> string_tree.append(
            "<!DOCTYPE html><html><head><meta http-equiv=\"refresh\" content=\"0; url=",
          )
          |> string_tree.append(value)
          |> string_tree.append("\"></head><body></body></html>"),
        ),
      )
      |> wisp.set_header("content-type", "text/html; charset=utf-8")
  }
}
