import gleam/dynamic.{type DecodeError, type Dynamic, DecodeError}
import gleam/json.{type Json}
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import widgets/component/component_interface.{
  type Component, type InnerNode, type Node, InnerNode, Node,
}

pub type Container(c, a) {
  Container(component: Component(c, a), content: List(c))
}

pub fn new(component: Component(c, a), content: List(c)) -> Container(c, a) {
  Container(component: component, content: content)
}

pub fn encode(container: Container(c, a)) -> Json {
  json.object([
    #("content", json.array(container.content, container.component.encode)),
  ])
}

pub fn decoder(
  component: Component(c, a),
) -> fn(Dynamic) -> Result(Container(c, a), List(DecodeError)) {
  dynamic.decode1(
    fn(content) { Container(component: component, content: content) },
    dynamic.field("content", dynamic.list(component.decoder)),
  )
}

pub fn render(container: Container(c, a)) -> Element(a) {
  render_template(
    container,
    list.map(container.content, container.component.render),
  )
}

pub fn render_tree(container: Container(c, a)) -> InnerNode(c, a) {
  let content = list.map(container.content, container.component.render_tree)

  InnerNode(
    children: content,
    element: render_template(
      container,
      list.map(content, fn(node: Node(c, a)) { node.element }),
    ),
  )
}

fn render_template(
  _container: Container(c, a),
  children: List(Element(a)),
) -> Element(a) {
  html.div([attribute.class("container"), attribute.class("mx-auto")], children)
}
