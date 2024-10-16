import component/component_interface.{type Component}
import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/json.{type Json}
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

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
  html.div([attribute.class("navbar")], [
    html.div(
      [attribute.class("navbar-start")],
      list.map(navbar.start, navbar.component.render),
    ),
    html.div(
      [attribute.class("navbar-center")],
      list.map(navbar.center, navbar.component.render),
    ),
    html.div(
      [attribute.class("navbar-end")],
      list.map(navbar.end, navbar.component.render),
    ),
  ])
}
