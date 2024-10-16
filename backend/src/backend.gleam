import gleam/bytes_builder
import gleam/erlang/process
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/io
import mist.{type Connection, type ResponseData}

pub fn main() {
  io.println("Hello from backend!")
  let assert Ok(_) =
    fn(_: Request(Connection)) -> Response(ResponseData) {
      response.Response(
        200,
        [#("content-type", "text/html; charset=utf-8")],
        mist.Bytes(bytes_builder.from_string("Hello from backend!")),
      )
    }
    |> mist.new
    |> mist.port(8161)
    |> mist.start_http

  process.sleep_forever()
}
