import gleam/dynamic.{type DecodeError, type Dynamic, DecodeError}
import gleam/json.{type Json}
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import widgets/component/component_interface.{
  type Component, type InnerNode, type Node, InnerNode, Node,
}

pub type Dialog(c, a) {
  Dialog(component: Component(c, a), content: List(c), open: Bool)
}

pub fn new(component: Component(c, a), content: List(c)) -> Dialog(c, a) {
  Dialog(component: component, content: content, open: False)
}

pub fn encode(dialog: Dialog(c, a)) -> Json {
  json.object([
    #("content", json.array(dialog.content, dialog.component.encode)),
  ])
}

pub fn decoder(
  component: Component(c, a),
) -> fn(Dynamic) -> Result(Dialog(c, a), List(DecodeError)) {
  dynamic.decode1(
    fn(content) { Dialog(component: component, content: content, open: False) },
    dynamic.field("content", dynamic.list(component.decoder)),
  )
}

pub fn render(dialog: Dialog(c, a)) -> Element(a) {
  render_template(dialog, list.map(dialog.content, dialog.component.render))
}

pub fn render_tree(dialog: Dialog(c, a)) -> InnerNode(c, a) {
  let content = list.map(dialog.content, dialog.component.render_tree)

  InnerNode(
    children: content,
    element: render_template(
      dialog,
      list.map(content, fn(node: Node(c, a)) { node.element }),
    ),
  )
}

fn render_template(
  dialog: Dialog(c, a),
  children: List(Element(a)),
) -> Element(a) {
  html.dialog([attribute.class("modal"), attribute.open(dialog.open)], [
    html.div([attribute.class("modal-box")], children),
  ])
}
