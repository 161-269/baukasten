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

/// https://tailwindcss.com/docs/font-family
pub type FontFamily {
  FontSans
  FontSerif
  FontMono
}

fn stringify_font_family(family: FontFamily) -> String {
  case family {
    FontSans -> "font-sans"
    FontSerif -> "font-serif"
    FontMono -> "font-mono"
  }
}

fn font_family_decoder(family: String) -> Result(FontFamily, List(DecodeError)) {
  case family {
    "font-sans" -> Ok(FontSans)
    "font-serif" -> Ok(FontSerif)
    "font-mono" -> Ok(FontMono)
    family ->
      Error([
        DecodeError("on of ['font-sans', 'font-serif', 'font-mono']", family, [
          "family",
        ]),
      ])
  }
}

/// https://tailwindcss.com/docs/font-size
pub type FontSize {
  TextXs
  TextSm
  TextBase
  TextLg
  TextXl
  Text2xl
  Text3xl
  Text4xl
  Text5xl
  Text6xl
  Text7xl
  Text8xl
  Text9xl
}

fn stringify_font_size(size: FontSize) -> String {
  case size {
    TextXs -> "text-xs"
    TextSm -> "text-sm"
    TextBase -> "text-base"
    TextLg -> "text-lg"
    TextXl -> "text-xl"
    Text2xl -> "text-2xl"
    Text3xl -> "text-3xl"
    Text4xl -> "text-4xl"
    Text5xl -> "text-5xl"
    Text6xl -> "text-6xl"
    Text7xl -> "text-7xl"
    Text8xl -> "text-8xl"
    Text9xl -> "text-9xl"
  }
}

fn font_size_decoder(size: String) -> Result(FontSize, List(DecodeError)) {
  case size {
    "text-xs" -> Ok(TextXs)
    "text-sm" -> Ok(TextSm)
    "text-base" -> Ok(TextBase)
    "text-lg" -> Ok(TextLg)
    "text-xl" -> Ok(TextXl)
    "text-2xl" -> Ok(Text2xl)
    "text-3xl" -> Ok(Text3xl)
    "text-4xl" -> Ok(Text4xl)
    "text-5xl" -> Ok(Text5xl)
    "text-6xl" -> Ok(Text6xl)
    "text-7xl" -> Ok(Text7xl)
    "text-8xl" -> Ok(Text8xl)
    "text-9xl" -> Ok(Text9xl)
    size ->
      Error([
        DecodeError(
          "on of ["
            <> "'text-xs', 'text-sm', 'text-base', 'text-lg', "
            <> "'text-xl', 'text-2xl', 'text-3xl', 'text-4xl', "
            <> "'text-5xl', 'text-6xl', 'text-7xl', 'text-8xl', "
            <> "'text-9xl']",
          size,
          ["size"],
        ),
      ])
  }
}

fn stringify_font_style(italic: Bool) -> String {
  case italic {
    True -> "italic"
    False -> "not-italic"
  }
}

fn font_style_decoder(italic: String) -> Result(Bool, List(DecodeError)) {
  case italic {
    "italic" -> Ok(True)
    "not-italic" -> Ok(False)
    italic ->
      Error([DecodeError("on of ['italic', 'not-italic']", italic, ["style"])])
  }
}

/// https://tailwindcss.com/docs/font-weight
pub type FontWeight {
  FontThin
  FontExtraLight
  FontLight
  FontNormal
  FontMedium
  FontSemiBold
  FontBold
  FontExtraBold
  FontBlack
}

fn stringify_font_weight(weight: FontWeight) -> String {
  case weight {
    FontThin -> "font-thin"
    FontExtraLight -> "font-extralight"
    FontLight -> "font-light"
    FontNormal -> "font-normal"
    FontMedium -> "font-medium"
    FontSemiBold -> "font-semibold"
    FontBold -> "font-bold"
    FontExtraBold -> "font-extrabold"
    FontBlack -> "font-black"
  }
}

fn font_weight_decoder(weight: String) -> Result(FontWeight, List(DecodeError)) {
  case weight {
    "font-thin" -> Ok(FontThin)
    "font-extralight" -> Ok(FontExtraLight)
    "font-light" -> Ok(FontLight)
    "font-normal" -> Ok(FontNormal)
    "font-medium" -> Ok(FontMedium)
    "font-semibold" -> Ok(FontSemiBold)
    "font-bold" -> Ok(FontBold)
    "font-extrabold" -> Ok(FontExtraBold)
    "font-black" -> Ok(FontBlack)
    weight ->
      Error([
        DecodeError(
          "on of ["
            <> "'font-thin', 'font-extralight', 'font-light', "
            <> "'font-normal', 'font-medium', 'font-semibold', "
            <> "'font-bold', 'font-extrabold', 'font-black']",
          weight,
          ["weight"],
        ),
      ])
  }
}

/// https://tailwindcss.com/docs/text-decoration
pub type TextDecoration {
  Underline
  Overline
  LineThrough
  NoUnderline
}

fn stringify_text_decoration(decoration: TextDecoration) -> String {
  case decoration {
    Underline -> "underline"
    Overline -> "overline"
    LineThrough -> "line-through"
    NoUnderline -> "no-underline"
  }
}

fn text_decoration_decoder(
  decoration: String,
) -> Result(TextDecoration, List(DecodeError)) {
  case decoration {
    "underline" -> Ok(Underline)
    "overline" -> Ok(Overline)
    "line-through" -> Ok(LineThrough)
    "no-underline" -> Ok(NoUnderline)
    decoration ->
      Error([
        DecodeError(
          "on of ['underline', 'overline', 'line-through', 'no-underline']",
          decoration,
          ["decoration"],
        ),
      ])
  }
}

pub type Text {
  Text(
    content: String,
    family: Option(FontFamily),
    size: Option(FontSize),
    italic: Option(Bool),
    weight: Option(FontWeight),
    decoration: Option(TextDecoration),
  )
}

pub fn text(content: String) -> Text {
  Text(
    content: content,
    family: None,
    size: None,
    italic: None,
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
pub fn italic(text: Text, italic: Bool) -> Text {
  Text(..text, italic: Some(italic))
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
    #("style", encode_nullable_string(text.italic, stringify_font_style)),
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
      text.italic |> option.map(stringify_font_style),
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
