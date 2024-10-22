import gleam/erlang/process
import gleam/json
import gleam/list
import lustre/attribute
import lustre/element
import lustre/element/html
import mist
import widgets/component.{type Component}
import widgets/component/article
import wisp.{type Request, type Response}
import wisp/wisp_mist

pub fn main() {
  let secret_key_base = wisp.random_string(64)

  let assert Ok(_) =
    wisp_mist.handler(handle_request(), secret_key_base)
    |> mist.new
    |> mist.bind("0.0.0.0")
    |> mist.port(8161)
    |> mist.start_http

  process.sleep_forever()
}

fn content() -> fn(Request) -> List(Component(a)) {
  let components = [component.article(article.djot("# Baukasten"))]
  fn(req: Request) {
    list.concat([
      components,
      [component.article(article.djot("## Pfad: " <> req.path))],
    ])
  }
}

fn handle_request() -> fn(Request) -> Response {
  let middleware_handler = middleware()
  let components = content()

  fn(req: Request) {
    use req <- middleware_handler(req)

    let components = components(req)

    let #(title, css, mjs, link_href, link_text) = case
      wisp.path_segments(req)
    {
      ["edit"] -> #(
        "Editor",
        html.link([
          attribute.rel("stylesheet"),
          attribute.href("/static/editor.min.css"),
        ]),
        "editor.min.mjs",
        "/",
        "Zurück zur Startseite",
      )
      _ -> #(
        "Baukasten",
        element.none(),
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
            attribute.href("/static/widgets.min.css"),
          ]),
          css,
          html.script(
            [
              attribute.attribute("defer", "defer"),
              attribute.type_("module"),
              attribute.src("/static/" <> mjs),
            ],
            "",
          ),
          html.script(
            [attribute.id("hydration"), attribute.type_("application/json")],
            components |> component.encode |> json.to_string,
          ),
        ]),
        html.body([], [
          html.a([attribute.href(link_href)], [html.text(link_text)]),
          html.div([attribute.id("app")], component.render(components)),
        ]),
      ])

    wisp.html_response(element.to_document_string_builder(result), 200)
  }
}

fn middleware() -> fn(wisp.Request, fn(wisp.Request) -> wisp.Response) ->
  wisp.Response {
  let assert Ok(priv) = wisp.priv_directory("backend")

  fn(req: wisp.Request, handle_request: fn(wisp.Request) -> wisp.Response) {
    use <- wisp.rescue_crashes
    let req = wisp.method_override(req)
    use req <- wisp.handle_head(req)

    use <- wisp.serve_static(req, under: "/static", from: priv)

    handle_request(req)
  }
}
