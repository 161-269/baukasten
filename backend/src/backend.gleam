import gleam/erlang/process
import gleam/io
import gleam/string_builder
import mist
import wisp.{type Request, type Response}
import wisp/wisp_mist

pub fn main() {
  io.println("Hello from backend!")
  wisp.configure_logger()

  let secret_key_base = wisp.random_string(64)

  let assert Ok(_) =
    wisp_mist.handler(handle_request, secret_key_base)
    |> mist.new
    |> mist.bind("0.0.0.0")
    |> mist.port(8161)
    |> mist.start_http

  process.sleep_forever()
}

fn handle_request(req: Request) -> Response {
  use _req <- middleware(req)

  let body = string_builder.from_string("<h1>Hello from backend!</h1>")

  wisp.html_response(body, 200)
}

fn middleware(
  req: wisp.Request,
  handle_request: fn(wisp.Request) -> wisp.Response,
) -> wisp.Response {
  let req = wisp.method_override(req)

  use <- wisp.log_request(req)

  use <- wisp.rescue_crashes

  use req <- wisp.handle_head(req)

  handle_request(req)
}
