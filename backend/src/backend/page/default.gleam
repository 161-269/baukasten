import backend/content
import gleam/json
import gleam/string_tree
import lustre/attribute
import lustre/element
import lustre/element/html
import widgets/component
import wisp.{type Request, type Response}

pub fn page() -> fn(Request) -> Response {
  let title = "Baukasten"
  let css = element.none()
  let mjs = "widgets.min.mjs"

  let content = content.content()

  fn(req: Request) -> Response {
    let #(components, tailwind_css) = content(req)

    case wisp.path_segments(req) {
      ["static", "widgets.min.css"] -> {
        wisp.response(200)
        |> wisp.set_header("Content-Type", "text/css; charset=utf-8")
        |> wisp.set_body(wisp.Text(string_tree.from_string(tailwind_css)))
      }

      _ -> {
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
              html.title([], "🛠️ " <> title),
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
              html.div([attribute.id("app")], component.render(components)),
            ]),
          ])
        wisp.html_response(element.to_document_string_builder(result), 200)
      }
    }
  }
}
