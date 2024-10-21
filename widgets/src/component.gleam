import component/article
import component/component_interface.{type Node, InnerNode, LeafNode, Node}
import component/navbar
import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/json.{type Json}
import gleam/list
import gleam/result
import helper/dynamic_helper
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub opaque type Component(a) {
  Article(article.Article)
  Navbar(navbar.Navbar(Component(a), a))
}

pub fn interface() -> component_interface.Component(Component(a), a) {
  component_interface.Component(
    encode: encode_component,
    decoder: component_decoder(),
    render: render_component,
    render_tree: render_tree,
  )
}

pub fn article(article: article.Article) -> Component(a) {
  Article(article)
}

pub fn navbar(
  start: List(Component(a)),
  center: List(Component(a)),
  end: List(Component(a)),
) -> Component(a) {
  Navbar(navbar.new(interface(), start, center, end))
}

pub fn encode(components: List(Component(a))) -> Json {
  json.array(components, encode_component)
}

pub fn encode_component(component: Component(a)) -> Json {
  json.object([
    #("type", json.string(component_type_name(component))),
    #("data", case component {
      Article(article) -> article.encode(article)
      Navbar(navbar) -> navbar.encode(navbar)
    }),
  ])
}

pub fn decoder() -> fn(Dynamic) -> Result(List(Component(a)), List(DecodeError)) {
  dynamic.list(component_decoder())
}

pub fn component_decoder() -> fn(Dynamic) ->
  Result(Component(a), List(DecodeError)) {
  dynamic.decode2(
    fn(component_type, data) {
      case component_type {
        "article" ->
          data_decoder(data, article.decoder(), Article, component_type)
        "navbar" ->
          data_decoder(
            data,
            navbar.decoder(interface()),
            Navbar,
            component_type,
          )
        component_type ->
          Error([
            dynamic.DecodeError(
              "on of ['article', 'navbar']",
              "'" <> component_type <> "'",
              ["type"],
            ),
          ])
      }
    },
    dynamic.field("type", dynamic.string),
    dynamic.field("data", dynamic.dynamic),
  )
  |> dynamic_helper.flatten
}

pub fn render(components: List(Component(a))) -> List(Element(a)) {
  list.map(components, render_component)
}

pub fn render_component(component: Component(a)) -> Element(a) {
  render_template(component_type_name(component), case component {
    Article(article) -> article.render(article)
    Navbar(navbar) -> navbar.render(navbar)
  })
}

pub fn render_tree(component: Component(a)) -> Node(Component(a), a) {
  let inner_node = case component {
    Article(article) -> article.render_tree(article)
    Navbar(navbar) -> navbar.render_tree(navbar)
  }

  let children = case inner_node {
    InnerNode(children, _) -> children
    LeafNode(_) -> []
  }

  let element = case inner_node {
    InnerNode(_, element) -> element
    LeafNode(element) -> element
  }

  Node(
    component: component,
    children: children,
    element: render_template(component_type_name(component), element),
  )
}

fn render_template(name: String, child: Element(a)) -> Element(a) {
  html.div(
    [
      attribute.class("component"),
      attribute.class("component-" <> name),
      attribute.attribute("data-component-type", name),
    ],
    [child],
  )
}

fn component_type_name(component: Component(a)) -> String {
  case component {
    Article(_) -> "article"
    Navbar(_) -> "navbar"
  }
}

fn data_decoder(
  data: Dynamic,
  decoder: fn(Dynamic) -> Result(a, List(DecodeError)),
  map: fn(a) -> b,
  component_type: String,
) -> Result(b, List(DecodeError)) {
  dynamic_helper.prepend_error(
    decoder,
    dynamic.DecodeError(
      "Could not decode component: '" <> component_type <> "'",
      "error",
      ["data"],
    ),
  )(data)
  |> result.map(map)
}
