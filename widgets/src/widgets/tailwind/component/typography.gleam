import gleam/dynamic.{type DecodeError, type Dynamic, DecodeError}
import gleam/json.{type Json}
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute}
import widgets/helper/attribute_helper
import widgets/helper/dynamic_helper.{decode_nullable_mapped_string_field}
import widgets/helper/json_helper.{encode_nullable_mapped_string}
import widgets/tailwind/class/typography.{
  type FontFamily, type FontSize, type FontStyle, type FontWeight,
  type TextDecoration, font_family_decoder, font_size_decoder,
  font_style_decoder, font_weight_decoder, stringify_font_family,
  stringify_font_size, stringify_font_style, stringify_font_weight,
  stringify_text_decoration, text_decoration_decoder,
}

pub type Typography {
  Typography(
    font_family: Option(FontFamily),
    font_size: Option(FontSize),
    font_style: Option(FontStyle),
    font_weight: Option(FontWeight),
    text_decoration: Option(TextDecoration),
  )
}

pub fn empty() -> Typography {
  Typography(
    font_family: None,
    font_size: None,
    font_style: None,
    font_weight: None,
    text_decoration: None,
  )
}

pub fn encode(typography: Typography) -> Json {
  json.object([
    #(
      "font-family",
      encode_nullable_mapped_string(
        typography.font_family,
        stringify_font_family,
      ),
    ),
    #(
      "font-size",
      encode_nullable_mapped_string(typography.font_size, stringify_font_size),
    ),
    #(
      "font-style",
      encode_nullable_mapped_string(typography.font_style, stringify_font_style),
    ),
    #(
      "font-weight",
      encode_nullable_mapped_string(
        typography.font_weight,
        stringify_font_weight,
      ),
    ),
    #(
      "text-decoration",
      encode_nullable_mapped_string(
        typography.text_decoration,
        stringify_text_decoration,
      ),
    ),
  ])
}

pub fn decoder() -> fn(Dynamic) -> Result(Typography, List(DecodeError)) {
  dynamic.decode5(
    Typography,
    decode_nullable_mapped_string_field("font-family", font_family_decoder),
    decode_nullable_mapped_string_field("font-size", font_size_decoder),
    decode_nullable_mapped_string_field("font-style", font_style_decoder),
    decode_nullable_mapped_string_field("font-weight", font_weight_decoder),
    decode_nullable_mapped_string_field(
      "text-decoration",
      text_decoration_decoder,
    ),
  )
}

pub fn attributes(typography: Typography) -> List(Attribute(a)) {
  attribute_helper.classify([
    typography.font_family |> option.map(stringify_font_family),
    typography.font_size |> option.map(stringify_font_size),
    typography.font_style |> option.map(stringify_font_style),
    typography.font_weight |> option.map(stringify_font_weight),
    typography.text_decoration |> option.map(stringify_text_decoration),
  ])
}
