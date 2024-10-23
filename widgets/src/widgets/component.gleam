import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/json.{type Json}
import gleam/list
import gleam/option.{type Option, None}
import gleam/result
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html
import widgets/component/article
import widgets/component/component_interface.{
  type Node, InnerNode, LeafNode, Node,
}
import widgets/component/navbar
import widgets/component/text
import widgets/counter
import widgets/helper/dynamic_helper

pub type Component(a, data) {
  Component(
    component: InnerComponent(a, data),
    attributes: List(Attribute(a)),
    id: Int,
    data: Option(data),
  )
}

pub type InnerComponent(a, data) {
  Article(article.Article)
  Navbar(navbar.Navbar(Component(a, data), a))
  Text(text.Text)
}

pub fn walk_map(
  components: List(Component(a, d)),
  with: fn(Component(a, d)) -> Component(a, d),
) -> List(Component(a, d)) {
  list.map(components, fn(component: Component(a, d)) {
    let component = with(component)

    case component.component {
      Article(_) -> component
      Text(_) -> component
      Navbar(value) ->
        Component(
          ..component,
          component: Navbar(
            navbar.Navbar(
              ..value,
              start: walk_map(value.start, with),
              center: walk_map(value.center, with),
              end: walk_map(value.end, with),
            ),
          ),
        )
    }
  })
}

pub fn walk_fold(
  components: List(Component(a, d)),
  from: result,
  with: fn(result, Component(a, d)) -> result,
) -> result {
  list.fold(components, from, fn(result, component: Component(a, d)) {
    let result = with(result, component)

    case component.component {
      Article(_) -> result
      Text(_) -> result
      Navbar(value) ->
        walk_fold(value.start, result, with)
        |> walk_fold(value.center, _, with)
        |> walk_fold(value.end, _, with)
    }
  })
}

pub fn update(
  components: List(Component(a, d)),
  id: Int,
  map: fn(Component(a, d)) -> Component(a, d),
) -> List(Component(a, d)) {
  walk_map(components, fn(component: Component(a, d)) {
    case component.id == id {
      True -> map(component)
      False -> component
    }
  })
}

pub fn clear_attributes(
  components: List(Component(a, d)),
) -> List(Component(a, d)) {
  walk_map(components, fn(component: Component(a, d)) {
    Component(..component, attributes: [])
  })
}

pub fn interface() -> component_interface.Component(Component(a, d), a) {
  component_interface.Component(
    encode: encode_component,
    decoder: component_decoder(),
    render: render_component,
    render_tree: render_tree,
  )
}

pub fn article(article: article.Article) -> Component(a, d) {
  Component(
    component: Article(article),
    attributes: [],
    id: counter.unique_integer(),
    data: None,
  )
}

pub fn navbar(
  start: List(Component(a, d)),
  center: List(Component(a, d)),
  end: List(Component(a, d)),
) -> Component(a, d) {
  Component(
    component: Navbar(navbar.new(interface(), start, center, end)),
    attributes: [],
    id: counter.unique_integer(),
    data: None,
  )
}

pub fn encode(components: List(Component(a, d))) -> Json {
  json.array(components, encode_component)
}

pub fn encode_component(component: Component(a, d)) -> Json {
  json.object([
    #("type", json.string(component_type_name(component))),
    #("data", case component.component {
      Article(article) -> article.encode(article)
      Navbar(navbar) -> navbar.encode(navbar)
      Text(text) -> text.encode(text)
    }),
  ])
}

pub fn decoder() -> fn(Dynamic) ->
  Result(List(Component(a, d)), List(DecodeError)) {
  dynamic.list(component_decoder())
}

pub fn component_decoder() -> fn(Dynamic) ->
  Result(Component(a, d), List(DecodeError)) {
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
  |> dynamic_helper.map(fn(component: InnerComponent(a, d)) {
    Ok(Component(
      component: component,
      attributes: [],
      id: counter.unique_integer(),
      data: None,
    ))
  })
}

pub fn render(components: List(Component(a, d))) -> List(Element(a)) {
  list.map(components, render_component)
}

pub fn render_component(component: Component(a, d)) -> Element(a) {
  render_template(component, case component.component {
    Article(article) -> article.render(article)
    Navbar(navbar) -> navbar.render(navbar)
    Text(text) -> text.render(text)
  })
}

pub fn render_tree(component: Component(a, d)) -> Node(Component(a, d), a) {
  let inner_node = case component.component {
    Article(article) -> article.render_tree(article)
    Navbar(navbar) -> navbar.render_tree(navbar)
    Text(text) -> text.render_tree(text)
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
    element: render_template(component, element),
  )
}

fn render_template(component: Component(a, d), child: Element(a)) -> Element(a) {
  let name = component_type_name(component)

  html.div(
    [
      attribute.class("component"),
      attribute.class("component-" <> name),
      attribute.attribute("data-component-type", name),
      ..component.attributes
    ],
    [child],
  )
}

fn component_type_name(component: Component(a, d)) -> String {
  case component.component {
    Article(_) -> "article"
    Navbar(_) -> "navbar"
    Text(_) -> "text"
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
