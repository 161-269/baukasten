import component
import ffi_bridge
import gleam/io
import gleam/json
import gleam/option.{None, Some}
import helper/json_helper
import lustre
import lustre/attribute
import lustre/effect
import lustre/element/html

pub fn main() {
  let in_dev_mode = ffi_bridge.in_web_dev_mode()
  case in_dev_mode {
    True -> start_dev_mode()
    False -> Nil
  }
}

fn start_dev_mode() {
  let hydration_state = ffi_bridge.hydration_state("hydration-dev")
  case hydration_state {
    Ok(Some(json_string)) -> {
      json_string
      |> io.println

      case json.decode(json_string, component.decoder()) {
        Ok(components) -> {
          let rendered =
            html.div([attribute.class("app")], component.render(components))

          let app =
            lustre.application(
              fn(_) { #(1, effect.none()) },
              fn(_, _) { #(1, effect.none()) },
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
        Error(error) -> {
          io.println_error("Error decoding component json")
          io.println_error(json_string)
          io.println_error(json_helper.stringify_decode_error(error))
        }
      }
    }
    Ok(None) -> {
      io.println_error("Hydration state not found")
    }
    Error(message) -> {
      io.println_error("Hydration state error")
      io.println_error(message)
    }
  }
}
