import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/json.{type Json}
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import widgets/component/component_interface.{
  type Component, type InnerNode, type Node, InnerNode,
}

pub opaque type Navbar(c, a) {
  Navbar(
    component: Component(c, a),
    start: List(c),
    center: List(c),
    end: List(c),
  )
}

pub fn new(
  component: Component(c, a),
  start: List(c),
  center: List(c),
  end: List(c),
) -> Navbar(c, a) {
  Navbar(component, start, center, end)
}

pub fn encode(navbar: Navbar(c, a)) -> Json {
  json.object([
    #("start", json.array(navbar.start, navbar.component.encode)),
    #("center", json.array(navbar.center, navbar.component.encode)),
    #("end", json.array(navbar.end, navbar.component.encode)),
  ])
}

pub fn decoder(
  component: Component(c, a),
) -> fn(Dynamic) -> Result(Navbar(c, a), List(DecodeError)) {
  dynamic.decode3(
    fn(start, center, end) { Navbar(component, start, center, end) },
    dynamic.field("start", dynamic.list(component.decoder)),
    dynamic.field("center", dynamic.list(component.decoder)),
    dynamic.field("end", dynamic.list(component.decoder)),
  )
}

pub fn render(navbar: Navbar(c, a)) -> Element(a) {
  render_template(
    list.map(navbar.start, navbar.component.render),
    list.map(navbar.center, navbar.component.render),
    list.map(navbar.end, navbar.component.render),
  )
}

pub fn render_tree(navbar: Navbar(c, a)) -> InnerNode(c, a) {
  let start = list.map(navbar.start, navbar.component.render_tree)
  let center = list.map(navbar.center, navbar.component.render_tree)
  let end = list.map(navbar.end, navbar.component.render_tree)

  let select_element = fn(node: Node(c, a)) { node.element }

  InnerNode(
    children: list.concat([start, center, end]),
    element: render_template(
      list.map(start, select_element),
      list.map(center, select_element),
      list.map(end, select_element),
    ),
  )
}

fn render_template(
  start: List(Element(a)),
  center: List(Element(a)),
  end: List(Element(a)),
) -> Element(a) {
  html.div([attribute.class("navbar")], [
    html.div([attribute.class("navbar-start")], start),
    html.div([attribute.class("navbar-center")], center),
    html.div([attribute.class("navbar-end")], end),
  ])
}
