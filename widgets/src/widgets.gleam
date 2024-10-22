import gleam/io
import gleam/json
import gleam/option.{Some}
import lustre
import lustre/effect
import lustre/element
import widgets/browser
import widgets/component

pub fn main() {
  let assert Ok(Some(hydration_json)) = browser.hydration_state("hydration")
  let assert Ok(components) = json.decode(hydration_json, component.decoder())
  let rendered = element.fragment(component.render(components))

  let app =
    lustre.application(
      fn(_) { #(1, effect.none()) },
      fn(_, _) { #(1, effect.none()) },
      fn(_) { rendered },
    )

  case lustre.start(app, "#app", Nil) {
    Ok(_) -> Nil
    Error(message) -> {
      io.println_error("Error starting app")
      io.debug(message)
      Nil
    }
  }
}
