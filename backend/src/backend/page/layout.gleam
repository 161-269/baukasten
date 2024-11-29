import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn minimal() -> fn(String, List(Element(a)), List(Element(a))) -> Element(a) {
  fn(title: String, head: List(Element(a)), body: List(Element(a))) -> Element(
    a,
  ) {
    html.html([attribute.attribute("lang", "en")], [
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
        html.link([attribute.rel("stylesheet"), attribute.href("/style.css")]),
        ..head
      ]),
      html.body([], body),
    ])
  }
}
