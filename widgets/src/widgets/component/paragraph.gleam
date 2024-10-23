import gleam/dynamic.{type DecodeError, type Dynamic, DecodeError}
import gleam/json.{type Json}
import gleam/list
import gleam/option.{Some}
import lustre/element.{type Element}
import lustre/element/html
import widgets/component/component_interface.{
  type Component, type InnerNode, type Node, InnerNode, Node,
}
import widgets/tailwind/class/typography.{
  type FontFamily, type FontSize, type FontStyle, type FontWeight,
  type TextDecoration,
} as _
import widgets/tailwind/component/typography.{type Typography, Typography}

pub type Paragraph(c, a) {
  Paragraph(
    component: Component(c, a),
    content: List(c),
    typography: Typography,
  )
}

pub fn new(component: Component(c, a), content: List(c)) -> Paragraph(c, a) {
  Paragraph(
    component: component,
    content: content,
    typography: typography.empty(),
  )
}

/// https://tailwindcss.com/docs/font-family
pub fn family(paragraph: Paragraph(c, a), family: FontFamily) -> Paragraph(c, a) {
  Paragraph(
    ..paragraph,
    typography: Typography(..paragraph.typography, font_family: Some(family)),
  )
}

/// https://tailwindcss.com/docs/font-size
pub fn size(paragraph: Paragraph(c, a), size: FontSize) -> Paragraph(c, a) {
  Paragraph(
    ..paragraph,
    typography: Typography(..paragraph.typography, font_size: Some(size)),
  )
}

/// https://tailwindcss.com/docs/font-style
pub fn italic(paragraph: Paragraph(c, a), style: FontStyle) -> Paragraph(c, a) {
  Paragraph(
    ..paragraph,
    typography: Typography(..paragraph.typography, font_style: Some(style)),
  )
}

/// https://tailwindcss.com/docs/font-weight
pub fn weight(paragraph: Paragraph(c, a), weight: FontWeight) -> Paragraph(c, a) {
  Paragraph(
    ..paragraph,
    typography: Typography(..paragraph.typography, font_weight: Some(weight)),
  )
}

/// https://tailwindcss.com/docs/text-decoration
pub fn decoration(
  paragraph: Paragraph(c, a),
  decoration: TextDecoration,
) -> Paragraph(c, a) {
  Paragraph(
    ..paragraph,
    typography: Typography(
      ..paragraph.typography,
      text_decoration: Some(decoration),
    ),
  )
}

pub fn encode(paragraph: Paragraph(c, a)) -> Json {
  json.object([
    #("content", json.array(paragraph.content, paragraph.component.encode)),
    #("typography", typography.encode(paragraph.typography)),
  ])
}

pub fn decoder(
  component: Component(c, a),
) -> fn(Dynamic) -> Result(Paragraph(c, a), List(DecodeError)) {
  dynamic.decode2(
    fn(content, typography) {
      Paragraph(component: component, content: content, typography: typography)
    },
    dynamic.field("content", dynamic.list(component.decoder)),
    dynamic.field("typography", typography.decoder()),
  )
}

pub fn render(paragraph: Paragraph(c, a)) -> Element(a) {
  render_template(
    paragraph,
    list.map(paragraph.content, paragraph.component.render),
  )
}

pub fn render_tree(paragraph: Paragraph(c, a)) -> InnerNode(c, a) {
  let content = list.map(paragraph.content, paragraph.component.render_tree)

  InnerNode(
    children: content,
    element: render_template(
      paragraph,
      list.map(content, fn(node: Node(c, a)) { node.element }),
    ),
  )
}

fn render_template(
  paragraph: Paragraph(c, a),
  children: List(Element(a)),
) -> Element(a) {
  html.p(typography.attributes(paragraph.typography), children)
}
