import gleam/dict.{type Dict}
import gleam/dynamic.{type DecodeError, type Dynamic, DecodeError}
import gleam/json.{type Json}
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string_tree
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html
import widgets/component/component_interface.{type InnerNode, LeafNode}
import widgets/helper/dynamic_helper
import widgets/not_my_code/jot
import widgets/tailwind/class/typography.{
  type FontFamily, type FontSize, type FontStyle, type FontWeight,
  type TextDecoration,
} as _
import widgets/tailwind/component/typography.{type Typography, Typography}

// https://htmlpreview.github.io/?https://github.com/jgm/djot/blob/master/doc/syntax.html

pub type Article {
  Text(content: String, typography: Typography)
  Djot(content: String, typography: Typography)
}

pub fn text(text: String) -> Article {
  Text(content: text, typography: typography.new())
}

pub fn djot(djot: String) -> Article {
  Djot(content: djot, typography: typography.new())
}

/// https://tailwindcss.com/docs/font-family
pub fn family(article: Article, family: FontFamily) -> Article {
  let typography = Typography(..article.typography, font_family: Some(family))

  case article {
    Text(content, _) -> Text(content, typography)
    Djot(content, _) -> Djot(content, typography)
  }
}

/// https://tailwindcss.com/docs/font-size
pub fn size(article: Article, size: FontSize) -> Article {
  let typography = Typography(..article.typography, font_size: Some(size))

  case article {
    Text(content, _) -> Text(content, typography)
    Djot(content, _) -> Djot(content, typography)
  }
}

/// https://tailwindcss.com/docs/font-style
pub fn italic(article: Article, style: FontStyle) -> Article {
  let typography = Typography(..article.typography, font_style: Some(style))

  case article {
    Text(content, _) -> Text(content, typography)
    Djot(content, _) -> Djot(content, typography)
  }
}

/// https://tailwindcss.com/docs/font-weight
pub fn weight(article: Article, weight: FontWeight) -> Article {
  let typography = Typography(..article.typography, font_weight: Some(weight))

  case article {
    Text(content, _) -> Text(content, typography)
    Djot(content, _) -> Djot(content, typography)
  }
}

/// https://tailwindcss.com/docs/text-decoration
pub fn decoration(article: Article, decoration: TextDecoration) -> Article {
  let typography =
    Typography(..article.typography, text_decoration: Some(decoration))

  case article {
    Text(content, _) -> Text(content, typography)
    Djot(content, _) -> Djot(content, typography)
  }
}

pub fn encode(article: Article) -> Json {
  json.object([
    #(
      "type",
      json.string(case article {
        Text(_, _) -> "text"
        Djot(_, _) -> "djot"
      }),
    ),
    #("content", json.string(article.content)),
    #("typography", typography.encode(article.typography)),
  ])
}

pub fn decoder() -> fn(Dynamic) -> Result(Article, List(DecodeError)) {
  dynamic.decode3(
    fn(article_type, content, typography) {
      case article_type {
        "text" -> Ok(Text(content: content, typography: typography))
        "djot" -> Ok(Djot(content: content, typography: typography))
        article_type ->
          Error([
            DecodeError("on of ['text', 'djot']", "'" <> article_type <> "'", [
              "type",
            ]),
          ])
      }
    },
    dynamic.field("type", dynamic.string),
    dynamic.field("content", dynamic.string),
    dynamic.field("typography", typography.decoder()),
  )
  |> dynamic_helper.flatten
}

pub fn render(article: Article) -> Element(a) {
  let content = case article {
    Text(_, _) -> [html.p([], [html.text(article.content)])]
    Djot(_, _) -> render_djot(jot.parse(article.content))
  }

  html.article(
    [
      attribute.class("prose lg:prose-xl w-full max-w-full"),
      ..typography.attributes(article.typography)
    ],
    content,
  )
}

pub fn render_tree(article: Article) -> InnerNode(c, a) {
  LeafNode(element: render(article))
}

fn render_djot(document: jot.Document) -> List(Element(a)) {
  list.map(document.content, render_djot_container(document.references))
}

fn render_djot_container(
  refs: Dict(String, String),
) -> fn(jot.Container) -> Element(a) {
  fn(container: jot.Container) {
    case container {
      jot.ThematicBreak -> html.hr([])

      jot.Codeblock(attrs, language, content) -> {
        let attrs = jot_attributes(attrs)
        let attrs = case language {
          None -> attrs
          Some(language) -> [attribute.class("language-" <> language), ..attrs]
        }

        html.pre([], [html.code(attrs, [html.text(content)])])
      }
      jot.Heading(attrs, level, inlines) -> {
        let tag = case level {
          1 -> html.h1
          2 -> html.h2
          3 -> html.h3
          4 -> html.h4
          5 -> html.h5
          6 -> html.h6
          _ -> html.span
        }

        tag(jot_attributes(attrs), list.map(inlines, render_djot_inline(refs)))
      }
      jot.Paragraph(attrs, inlines) ->
        html.p(
          jot_attributes(attrs),
          list.map(inlines, render_djot_inline(refs)),
        )
    }
  }
}

fn render_djot_inline(
  refs: Dict(String, String),
) -> fn(jot.Inline) -> Element(a) {
  fn(inline: jot.Inline) -> Element(a) {
    case inline {
      jot.Code(content) -> html.code([], [html.text(content)])
      jot.Emphasis(inlines) ->
        html.em([], list.map(inlines, render_djot_inline(refs)))
      jot.Image(inlines, destination) ->
        html.img([
          option.map(djot_destination(destination, refs), attribute.src)
            |> option.unwrap(attribute.none()),
          attribute.alt(
            string_tree.to_string(djot_inline_text(inlines, string_tree.new())),
          ),
        ])
      jot.Linebreak -> html.br([])
      jot.Link(inlines, destination) ->
        html.a(
          [
            option.map(djot_destination(destination, refs), attribute.href)
            |> option.unwrap(attribute.none()),
          ],
          list.map(inlines, render_djot_inline(refs)),
        )

      jot.Strong(inlines) ->
        html.strong([], list.map(inlines, render_djot_inline(refs)))
      jot.Text(content) -> html.text(content)
    }
  }
}

fn djot_destination(
  destination: jot.Destination,
  refs: Dict(String, String),
) -> Option(String) {
  case destination {
    jot.Url(url) -> Some(url)
    jot.Reference(reference) -> {
      dict.get(refs, reference) |> result.map(Some) |> result.unwrap(None)
    }
  }
}

fn djot_inline_text(
  inlines: List(jot.Inline),
  accumulator: string_tree.StringTree,
) -> string_tree.StringTree {
  case inlines {
    [] -> accumulator
    [first, ..rest] ->
      case first {
        jot.Text(text) | jot.Code(text) ->
          djot_inline_text(rest, string_tree.append(accumulator, text))
        jot.Strong(inlines)
        | jot.Emphasis(inlines)
        | jot.Link(inlines, _)
        | jot.Image(inlines, _) ->
          djot_inline_text(rest, djot_inline_text(inlines, accumulator))
        jot.Linebreak ->
          djot_inline_text(rest, string_tree.append(accumulator, " "))
      }
  }
}

fn jot_attributes(attributes: Dict(String, String)) -> List(Attribute(a)) {
  dict.to_list(attributes)
  |> list.map(fn(tuple) {
    let #(key, value) = tuple
    attribute.attribute(key, value)
  })
}
