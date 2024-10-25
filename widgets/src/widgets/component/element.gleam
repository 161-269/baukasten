import gleam/dynamic.{type DecodeError, type Dynamic, DecodeError}
import gleam/json.{type Json}
import gleam/list
import gleam/result
import lustre/attribute
import lustre/element.{type Element as LustreElement}
import lustre/element/html
import widgets/component/component_interface.{
  type Component, type InnerNode, type Node, InnerNode, Node,
}

pub type Element(c, a) {
  Element(
    component: Component(c, a),
    content: List(c),
    tag: Tag,
    classes: List(String),
  )
}

pub type Tag {
  Div
  Paragraph
  Span
  Button
}

pub fn new(
  component: Component(c, a),
  content: List(c),
  tag: Tag,
  classes: List(String),
) -> Element(c, a) {
  Element(component: component, content: content, tag: tag, classes: classes)
}

pub fn encode(element: Element(c, a)) -> Json {
  json.object([
    #("content", json.array(element.content, element.component.encode)),
    #(
      "tag",
      json.string(case element.tag {
        Div -> "div"
        Paragraph -> "p"
        Span -> "span"
        Button -> "button"
      }),
    ),
    #("classes", json.array(element.classes, json.string)),
  ])
}

pub fn decoder(
  component: Component(c, a),
) -> fn(Dynamic) -> Result(Element(c, a), List(DecodeError)) {
  dynamic.decode3(
    fn(content, tag, classes) {
      Element(
        component: component,
        content: content,
        tag: tag,
        classes: classes,
      )
    },
    dynamic.field("content", dynamic.list(component.decoder)),
    dynamic.field("tag", tag_decoder),
    dynamic.field("classes", dynamic.list(dynamic.string)),
  )
}

fn tag_decoder(value: Dynamic) -> Result(Tag, List(DecodeError)) {
  dynamic.string(value)
  |> result.then(fn(value: String) {
    case value {
      "div" -> Ok(Div)
      "p" -> Ok(Paragraph)
      "span" -> Ok(Span)
      "button" -> Ok(Button)
      _ ->
        Error([
          DecodeError("on of ['div', 'p', 'span', 'button']", value, ["tag"]),
        ])
    }
  })
}

pub fn render(element: Element(c, a)) -> LustreElement(a) {
  render_template(element, list.map(element.content, element.component.render))
}

pub fn render_tree(element: Element(c, a)) -> InnerNode(c, a) {
  let content = list.map(element.content, element.component.render_tree)

  InnerNode(
    children: content,
    element: render_template(
      element,
      list.map(content, fn(node: Node(c, a)) { node.element }),
    ),
  )
}

fn render_template(
  element: Element(c, a),
  children: List(LustreElement(a)),
) -> LustreElement(a) {
  let tag = case element.tag {
    Button -> html.button
    Div -> html.div
    Paragraph -> html.p
    Span -> html.span
  }
  tag(list.map(element.classes, attribute.class), children)
}
