import ffi_bridge
import gleam/io
import gleam/json
import gleam/option.{None, Some}
import lustre
import lustre/attribute
import lustre/effect
import lustre/element/html
import widgets/component
import widgets/helper/json_helper

pub fn main() {
  let hydration_state = ffi_bridge.hydration_state("hydration-dev")
  case hydration_state {
    Ok(Some(json_string)) -> {
      // let json_string =
      //   [
      //     component.navbar(
      //       [component.article(article.text("Start"))],
      //       [component.article(article.text("Center"))],
      //       [component.article(article.text("End"))],
      //     ),
      //     component.navbar(
      //       [],
      //       [
      //         component.article(article.text("A")),
      //         component.article(article.text("B")),
      //         component.article(article.text("C")),
      //       ],
      //       [],
      //     ),
      //     component.article(article.text("Hello from dev mode!")),
      //     component.article(article.djot(
      //       "_This is *regular* not strong* emphasis",
      //     )),
      //     component.article(article.djot(
      //       "*This is _strong* not regular_ emphasis",
      //     )),
      //     component.article(article.djot("[Link *](url)*")),
      //     component.article(article.djot("*Emphasis [*](url)")),
      //     component.article(article.djot(
      //       "_This is *strong within* regular emphasis_",
      //     )),
      //     component.article(article.djot(
      //       "{_Emphasized_}
      //                     _}not emphasized{_",
      //     )),
      //     component.article(article.djot("*not strong *strong*")),
      //     component.article(article.djot("[My link text](http://example.com)")),
      //     component.article(article.djot(
      //       "[My link text](http://example.com?product_number=234234234234234234234234)",
      //     )),
      //     component.article(article.djot(
      //       "[My link text][foo bar]
      //       
      //                   [foo bar]: http://example.com",
      //     )),
      //     component.article(article.djot("[foo][bar]")),
      //     component.article(article.djot(
      //       "``Verbatim with a backtick` character``
      //       `Verbatim with three backticks ``` character`",
      //     )),
      //     component.article(article.djot("This is {=highlighted text=}.")),
      //     component.article(article.djot("H~2~O and djot^TM^")),
      //     component.article(article.djot("H{~one two buckle my shoe~}O")),
      //     component.article(article.djot("My boss is {-mean-}{+nice+}.")),
      //   ]
      //   |> component.encode
      //   |> json.to_string

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
