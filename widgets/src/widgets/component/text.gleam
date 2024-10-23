import gleam/dynamic.{type DecodeError, type Dynamic, DecodeError}
import gleam/json.{type Json}
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html
import widgets/component/component_interface.{type InnerNode, LeafNode}
import widgets/helper/dynamic_helper
import widgets/tailwind/typography.{
  type FontFamily, type FontSize, type FontStyle, type FontWeight,
  type TextDecoration, font_family_decoder, font_size_decoder,
  font_style_decoder, font_weight_decoder, stringify_font_family,
  stringify_font_size, stringify_font_style, stringify_font_weight,
  stringify_text_decoration, text_decoration_decoder,
}

pub type Text {
  Text(
    content: String,
    family: Option(FontFamily),
    size: Option(FontSize),
    style: Option(FontStyle),
    weight: Option(FontWeight),
    decoration: Option(TextDecoration),
  )
}

pub fn text(content: String) -> Text {
  Text(
    content: content,
    family: None,
    size: None,
    style: None,
    weight: None,
    decoration: None,
  )
}

/// https://tailwindcss.com/docs/font-family
pub fn family(text: Text, family: FontFamily) -> Text {
  Text(..text, family: Some(family))
}

/// https://tailwindcss.com/docs/font-size
pub fn size(text: Text, size: FontSize) -> Text {
  Text(..text, size: Some(size))
}

/// https://tailwindcss.com/docs/font-style
pub fn italic(text: Text, style: FontStyle) -> Text {
  Text(..text, style: Some(style))
}

/// https://tailwindcss.com/docs/font-weight
pub fn weight(text: Text, weight: FontWeight) -> Text {
  Text(..text, weight: Some(weight))
}

/// https://tailwindcss.com/docs/text-decoration
pub fn decoration(text: Text, decoration: TextDecoration) -> Text {
  Text(..text, decoration: Some(decoration))
}

pub fn encode(text: Text) -> Json {
  json.object([
    #("content", json.string(text.content)),
    #("family", encode_nullable_string(text.family, stringify_font_family)),
    #("size", encode_nullable_string(text.size, stringify_font_size)),
    #("style", encode_nullable_string(text.style, stringify_font_style)),
    #("weight", encode_nullable_string(text.weight, stringify_font_weight)),
    #(
      "decoration",
      encode_nullable_string(text.decoration, stringify_text_decoration),
    ),
  ])
}

pub fn decoder() -> fn(Dynamic) -> Result(Text, List(DecodeError)) {
  dynamic.decode6(
    Text,
    dynamic.field("content", dynamic.string),
    decode_nullable_string_field("family", font_family_decoder),
    decode_nullable_string_field("size", font_size_decoder),
    decode_nullable_string_field("style", font_style_decoder),
    decode_nullable_string_field("weight", font_weight_decoder),
    decode_nullable_string_field("decoration", text_decoration_decoder),
  )
}

pub fn render(text: Text) -> Element(a) {
  html.span(
    attributify([
      text.family |> option.map(stringify_font_family),
      text.size |> option.map(stringify_font_size),
      text.style |> option.map(stringify_font_style),
      text.weight |> option.map(stringify_font_weight),
      text.decoration |> option.map(stringify_text_decoration),
    ]),
    [html.text(text.content)],
  )
}

pub fn render_tree(text: Text) -> InnerNode(c, a) {
  LeafNode(element: render(text))
}

fn encode_nullable_string(value: Option(a), map: fn(a) -> String) -> Json {
  case value {
    Some(value) -> json.string(map(value))
    None -> json.null()
  }
}

fn decode_nullable_string_field(
  field: String,
  map: fn(String) -> Result(a, List(DecodeError)),
) -> fn(Dynamic) -> Result(Option(a), List(DecodeError)) {
  dynamic.field(
    field,
    dynamic.optional(dynamic.string)
      |> dynamic_helper.map(fn(value: Option(String)) {
        case value {
          Some(value) -> map(value) |> result.map(Some)
          None -> Ok(None)
        }
      }),
  )
}

fn attributify(attributes: List(Option(String))) -> List(Attribute(a)) {
  list.filter_map(attributes, fn(attribute: Option(String)) {
    case attribute {
      Some(attribute) -> Ok(attribute.class(attribute))
      None -> Error(Nil)
    }
  })
}
