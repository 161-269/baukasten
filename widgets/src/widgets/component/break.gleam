import gleam/dynamic.{type DecodeError, type Dynamic, DecodeError}
import gleam/json.{type Json}
import lustre/element.{type Element}
import lustre/element/html
import widgets/component/component_interface.{type InnerNode, LeafNode}

pub type Break {
  Break
}

pub fn new() -> Break {
  Break
}

pub fn encode(_break: Break) -> Json {
  json.null()
}

pub fn decoder() -> fn(Dynamic) -> Result(Break, List(DecodeError)) {
  fn(_) { Ok(Break) }
}

pub fn render(_break: Break) -> Element(a) {
  html.br([])
}

pub fn render_tree(break: Break) -> InnerNode(c, a) {
  LeafNode(element: render(break))
}
