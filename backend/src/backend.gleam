import gleam/erlang/process
import gleam/io
import lustre/attribute
import lustre/element
import lustre/element/html
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
  use req <- middleware(req)

  let #(title, css, mjs, link_href, link_text) = case wisp.path_segments(req) {
    ["edit"] -> #(
      "Editor",
      "editor.min.css",
      "editor.min.mjs",
      "/",
      "Zurück zur Startseite",
    )
    _ -> #(
      "Baukasten",
      "widgets.min.css",
      "widgets.min.mjs",
      "/edit",
      "Zum Editor",
    )
  }

  let result =
    html.html([attribute.attribute("lang", "de")], [
      html.head([], [
        html.meta([attribute.attribute("charset", "utf-8")]),
        html.meta([
          attribute.name("viewport"),
          attribute.attribute(
            "content",
            "width=device-width, initial-scale=1.0",
          ),
        ]),
        html.title([], title),
        html.link([
          attribute.rel("stylesheet"),
          attribute.href("/static/fonts.css"),
        ]),
        html.link([
          attribute.rel("stylesheet"),
          attribute.href("/static/" <> css),
        ]),
        html.script(
          [
            attribute.attribute("defer", "defer"),
            attribute.type_("module"),
            attribute.src("/static/" <> mjs),
          ],
          "",
        ),
      ]),
      html.body([], [
        html.a([attribute.href(link_href)], [html.text(link_text)]),
        html.div([attribute.id("app")], []),
      ]),
    ])

  wisp.html_response(element.to_document_string_builder(result), 200)
}

fn middleware(
  req: wisp.Request,
  handle_request: fn(wisp.Request) -> wisp.Response,
) -> wisp.Response {
  let req = wisp.method_override(req)

  use <- wisp.log_request(req)

  use <- wisp.rescue_crashes

  use req <- wisp.handle_head(req)

  let assert Ok(priv) = wisp.priv_directory("backend")
  use <- wisp.serve_static(req, under: "/static", from: priv)

  handle_request(req)
}
