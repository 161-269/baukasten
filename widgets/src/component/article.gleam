import gleam/dict.{type Dict}
import gleam/dynamic.{type DecodeError, type Dynamic, DecodeError}
import gleam/json.{type Json}
import gleam/list
import gleam/option.{None, Some}
import gleam/result
import gleam/string_builder
import helper/dynamic_helper
import jot
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

// https://htmlpreview.github.io/?https://github.com/jgm/djot/blob/master/doc/syntax.html

pub opaque type Article {
  Text(String)
  Djot(String)
}

pub fn text(text: String) -> Article {
  Text(text)
}

pub fn djot(djot: String) -> Article {
  Djot(djot)
}

pub fn encode(article: Article) -> Json {
  json.object([
    #(
      "type",
      json.string(case article {
        Text(_) -> "text"
        Djot(_) -> "djot"
      }),
    ),
    #(
      "content",
      json.string(case article {
        Text(text) | Djot(text) -> text
      }),
    ),
  ])
}

pub fn decoder() -> fn(Dynamic) -> Result(Article, List(DecodeError)) {
  dynamic.decode2(
    fn(article_type, content) {
      case article_type {
        "text" -> Ok(Text(content))
        "djot" -> Ok(Djot(content))
        article_type ->
          Error([DecodeError("on of ['text', 'djot']", article_type, ["type"])])
      }
    },
    dynamic.field("type", dynamic.string),
    dynamic.field("content", dynamic.string),
  )
  |> dynamic_helper.flatten
}

pub fn render(article: Article) -> Element(a) {
  let content = case article {
    Text(text) -> [html.p([], [html.text(text)])]
    Djot(djot) -> render_djot(jot.parse(djot))
  }

  html.article([attribute.class("prose lg:prose-xl")], content)
}

fn render_djot(document: jot.Document) -> List(Element(a)) {
  list.map(document.content, render_djot_container(document.references))
}

fn render_djot_container(
  refs: Dict(String, String),
) -> fn(jot.Container) -> Element(a) {
  fn(container: jot.Container) {
    case container {
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
        html.a(
          [attribute.href(djot_destination(destination, refs))],
          list.map(inlines, render_djot_inline(refs)),
        )
      jot.Linebreak -> html.br([])
      jot.Link(inlines, destination) ->
        html.img([
          attribute.src(djot_destination(destination, refs)),
          attribute.alt(
            string_builder.to_string(djot_inline_text(
              inlines,
              string_builder.new(),
            )),
          ),
        ])
      jot.Strong(inlines) ->
        html.strong([], list.map(inlines, render_djot_inline(refs)))
      jot.Text(content) -> html.text(content)
    }
  }
}

fn djot_destination(
  destination: jot.Destination,
  refs: Dict(String, String),
) -> String {
  case destination {
    jot.Url(url) -> url
    jot.Reference(reference) -> dict.get(refs, reference) |> result.unwrap("")
  }
}

fn djot_inline_text(
  inlines: List(jot.Inline),
  accumulator: string_builder.StringBuilder,
) -> string_builder.StringBuilder {
  case inlines {
    [] -> accumulator
    [first, ..rest] ->
      case first {
        jot.Text(text) | jot.Code(text) ->
          djot_inline_text(rest, string_builder.append(accumulator, text))
        jot.Strong(inlines)
        | jot.Emphasis(inlines)
        | jot.Link(inlines, _)
        | jot.Image(inlines, _) ->
          djot_inline_text(rest, djot_inline_text(inlines, accumulator))
        jot.Linebreak ->
          djot_inline_text(rest, string_builder.append(accumulator, " "))
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
