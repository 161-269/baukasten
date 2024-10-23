import gleam/dynamic.{type DecodeError, DecodeError}

/// https://tailwindcss.com/docs/font-family
pub type FontFamily {
  FontSans
  FontSerif
  FontMono
}

pub fn stringify_font_family(family: FontFamily) -> String {
  case family {
    FontSans -> "font-sans"
    FontSerif -> "font-serif"
    FontMono -> "font-mono"
  }
}

pub fn font_family_decoder(
  family: String,
) -> Result(FontFamily, List(DecodeError)) {
  case family {
    "font-sans" -> Ok(FontSans)
    "font-serif" -> Ok(FontSerif)
    "font-mono" -> Ok(FontMono)
    family ->
      Error([
        DecodeError("on of ['font-sans', 'font-serif', 'font-mono']", family, [
          "font-family",
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

pub fn stringify_font_size(size: FontSize) -> String {
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

pub fn font_size_decoder(size: String) -> Result(FontSize, List(DecodeError)) {
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

/// https://tailwindcss.com/docs/font-style
pub type FontStyle {
  Italic
  NotItalic
}

pub fn stringify_font_style(italic: FontStyle) -> String {
  case italic {
    Italic -> "italic"
    NotItalic -> "not-italic"
  }
}

pub fn font_style_decoder(
  italic: String,
) -> Result(FontStyle, List(DecodeError)) {
  case italic {
    "italic" -> Ok(Italic)
    "not-italic" -> Ok(NotItalic)
    italic ->
      Error([
        DecodeError("on of ['italic', 'not-italic']", italic, ["font-style"]),
      ])
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

pub fn stringify_font_weight(weight: FontWeight) -> String {
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

pub fn font_weight_decoder(
  weight: String,
) -> Result(FontWeight, List(DecodeError)) {
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
          ["font-weight"],
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

pub fn stringify_text_decoration(decoration: TextDecoration) -> String {
  case decoration {
    Underline -> "underline"
    Overline -> "overline"
    LineThrough -> "line-through"
    NoUnderline -> "no-underline"
  }
}

pub fn text_decoration_decoder(
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
          ["font-decoration"],
        ),
      ])
  }
}
