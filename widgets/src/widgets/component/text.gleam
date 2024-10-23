import gleam/dynamic.{type DecodeError, type Dynamic, DecodeError}
import gleam/json.{type Json}
import gleam/option.{Some}
import lustre/element.{type Element}
import lustre/element/html
import widgets/component/component_interface.{type InnerNode, LeafNode}
import widgets/tailwind/class/typography.{
  type FontFamily, type FontSize, type FontStyle, type FontWeight,
  type TextDecoration,
} as _
import widgets/tailwind/component/typography.{type Typography, Typography}

pub type Text {
  Text(content: String, typography: Typography)
}

pub fn text(content: String) -> Text {
  Text(content: content, typography: typography.empty())
}

/// https://tailwindcss.com/docs/font-family
pub fn family(text: Text, family: FontFamily) -> Text {
  Text(
    ..text,
    typography: Typography(..text.typography, font_family: Some(family)),
  )
}

/// https://tailwindcss.com/docs/font-size
pub fn size(text: Text, size: FontSize) -> Text {
  Text(..text, typography: Typography(..text.typography, font_size: Some(size)))
}

/// https://tailwindcss.com/docs/font-style
pub fn italic(text: Text, style: FontStyle) -> Text {
  Text(
    ..text,
    typography: Typography(..text.typography, font_style: Some(style)),
  )
}

/// https://tailwindcss.com/docs/font-weight
pub fn weight(text: Text, weight: FontWeight) -> Text {
  Text(
    ..text,
    typography: Typography(..text.typography, font_weight: Some(weight)),
  )
}

/// https://tailwindcss.com/docs/text-decoration
pub fn decoration(text: Text, decoration: TextDecoration) -> Text {
  Text(
    ..text,
    typography: Typography(..text.typography, text_decoration: Some(decoration)),
  )
}

pub fn encode(text: Text) -> Json {
  json.object([
    #("content", json.string(text.content)),
    #("typography", typography.encode(text.typography)),
  ])
}

pub fn decoder() -> fn(Dynamic) -> Result(Text, List(DecodeError)) {
  dynamic.decode2(
    Text,
    dynamic.field("content", dynamic.string),
    dynamic.field("family", typography.decoder()),
  )
}

pub fn render(text: Text) -> Element(a) {
  html.span(typography.attributes(text.typography), [html.text(text.content)])
}

pub fn render_tree(text: Text) -> InnerNode(c, a) {
  LeafNode(element: render(text))
}
