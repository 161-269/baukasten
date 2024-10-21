import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/json.{type Json}
import lustre/element.{type Element}

pub type Component(c, a) {
  Component(
    encode: fn(c) -> Json,
    decoder: fn(Dynamic) -> Result(c, List(DecodeError)),
    render: fn(c) -> Element(a),
    render_tree: fn(c) -> Node(c, a),
  )
}

pub type Node(c, a) {
  Node(component: c, children: List(Node(c, a)), element: Element(a))
}

pub type InnerNode(c, a) {
  InnerNode(children: List(Node(c, a)), element: Element(a))
  LeafNode(element: Element(a))
}
