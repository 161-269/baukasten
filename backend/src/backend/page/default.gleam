import backend/content
import backend/tailwind_new.{type Tailwind}
import gleam/json
import lustre/attribute
import lustre/element
import lustre/element/html
import widgets/component
import wisp.{type Request, type Response}

pub fn page(tailwind: Tailwind) -> fn(Request) -> Response {
  let title = "Baukasten"
  let css = element.none()
  let mjs = "widgets.min.mjs"

  let content = content.content(tailwind)

  fn(req: Request) -> Response {
    let components = content(req)

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
          html.link([attribute.rel("stylesheet"), attribute.href("/style.css")]),
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
