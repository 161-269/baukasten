import component/article
import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/json.{type Json}
import gleam/list
import gleam/result
import helper/dynamic_helper
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub opaque type Component {
  Article(article.Article)
}

pub fn article(article: article.Article) -> Component {
  Article(article)
}

pub fn encode(components: List(Component)) -> Json {
  json.array(components, encode_component)
}

pub fn encode_component(component: Component) -> Json {
  json.object([
    #("type", json.string(component_type_name(component))),
    #("data", case component {
      Article(article) -> article.encode(article)
    }),
  ])
}

pub fn decoder() -> fn(Dynamic) -> Result(List(Component), List(DecodeError)) {
  dynamic.list(component_decoder())
}

pub fn component_decoder() -> fn(Dynamic) ->
  Result(Component, List(DecodeError)) {
  dynamic.decode2(
    fn(component_type, data) {
      case component_type {
        "article" ->
          data_decoder(data, article.decoder(), Article, component_type)
        component_type ->
          Error([
            dynamic.DecodeError(
              "on of ['article']",
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

pub fn render(components: List(Component)) -> List(Element(a)) {
  list.map(components, render_component)
}

pub fn render_component(component: Component) -> Element(a) {
  html.div(
    [
      attribute.class("component"),
      attribute.class("component-" <> component_type_name(component)),
      attribute.attribute("data-component-type", component_type_name(component)),
    ],
    case component {
      Article(article) -> [article.render(article)]
    },
  )
}

fn component_type_name(component: Component) -> String {
  case component {
    Article(_) -> "article"
  }
}

fn data_decoder(
  data: Dynamic,
  decoder: fn(Dynamic) -> Result(a, List(DecodeError)),
  map: fn(a) -> b,
  component_type: String,
) -> Result(b, List(DecodeError)) {
  decoder(data)
  |> result.map(map)
  |> result.map_error(fn(error) {
    [
      dynamic.DecodeError(
        "Could not decode component: '" <> component_type <> "'",
        "error",
        ["data"],
      ),
      ..error
    ]
  })
}
