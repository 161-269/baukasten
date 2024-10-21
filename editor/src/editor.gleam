import gleam/io

import lustre
import lustre/attribute
import lustre/effect
import lustre/element/html
import widgets/component

pub fn main() {
  let rendered = html.div([attribute.class("app")], component.render([]))

  let app =
    lustre.application(
      fn(_) { #(Nil, effect.none()) },
      fn(_, _) { #(Nil, effect.none()) },
      fn(_) { rendered },
    )

  case lustre.start(app, "#app-dev", Nil) {
    Ok(_) -> Nil
    Error(message) -> {
      io.println_error("Error starting app")
      io.debug(message)
      Nil
    }
  }
}
