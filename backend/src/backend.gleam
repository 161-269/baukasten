import backend/database
import backend/database/configuration
import backend/middleware
import backend/tailwind
import birl
import gleam/erlang/process
import gleam/io
import gleam/json
import gleam/option.{None, Some}
import gleam/result
import gleam/string_tree
import lustre/attribute
import lustre/element
import lustre/element/html
import mist
import simplifile
import sqlight
import widgets/component
import wisp.{type Request, type Response}
import wisp/wisp_mist

pub fn main() {
  case simplifile.create_directory_all("./data") {
    Ok(_) -> Nil
    Error(error) -> {
      io.println_error("Error creating data directory:")
      io.debug(error)
      panic as "Could not create data directory"
    }
  }

  let db = case database.connect("./data/database.sqlite", 16, 60_000) {
    Ok(db) -> db
    Error(error) -> {
      io.println_error("Error connecting to database:")
      io.debug(error)
      panic as "Could not connect to database"
    }
  }

  // TODO: Don't assume, start the app in a failed state and
  // output error messages so the pages can be accessed
  let assert Ok(_) = tailwind.delete_temporary_files()

  let assert Ok(secret_key_base) =
    database.connection(db, 100, fn(error) { error }, fn(connection) {
      secret_key_base(connection) |> result.map_error(database.SqlightError)
    })

  let assert Ok(_) =
    wisp_mist.handler(handle_request(db), secret_key_base)
    |> mist.new
    |> mist.bind("0.0.0.0")
    |> mist.port(8161)
    |> mist.start_http

  process.sleep_forever()
}

fn secret_key_base(db: sqlight.Connection) -> Result(String, sqlight.Error) {
  use value <- result.try(configuration.get(db, "general.secret_key_base"))

  case value {
    Some(value) -> Ok(value.value)
    None -> {
      let secret_key_base = wisp.random_string(128)

      use _ <- result.try(configuration.set(
        db,
        "general.secret_key_base",
        secret_key_base,
        birl.now() |> birl.to_unix_milli,
      ))

      Ok(secret_key_base)
    }
  }
}

fn handle_request(db: database.Db) -> fn(Request) -> Response {
  let middleware_handler = middleware(db)

  fn(req: Request) {
    let #(components, tailwind_css) = #([], "")
    use _req, path_segments <- middleware_handler(req, tailwind_css)

    use <-
      fn(next: fn() -> Response) -> Response {
        case path_segments {
          ["maintenance", "login"] ->
            wisp.response(200)
            |> wisp.file_download("database.sqlite", "./data/database.sqlite")

          _ -> next()
        }
      }

    let #(title, css, mjs, link_href, link_text) = case path_segments {
      ["edit"] -> #(
        "Editor",
        html.link([
          attribute.rel("stylesheet"),
          attribute.href("/static/editor.min.css"),
        ]),
        "editor.min.mjs",
        "/",
        "Zurück zur Startseite",
      )
      _ -> #(
        "Baukasten",
        element.none(),
        "widgets.min.mjs",
        "/edit",
        "Zum Editor",
      )
    }

    let result =
      html.html([attribute.attribute("lang", "de")], [
        html.head([], [
          html.meta([attribute.attribute("charset", "utf-8")]),
          html.meta([
            attribute.name("viewport"),
            attribute.attribute(
              "content",
              "width=device-width, initial-scale=1.0",
            ),
          ]),
          html.title([], "🛠️ " <> title),
          html.link([
            attribute.rel("stylesheet"),
            attribute.href("/static/fonts.css"),
          ]),
          html.link([
            attribute.rel("stylesheet"),
            attribute.href("/static/widgets.min.css"),
          ]),
          css,
          html.script(
            [
              attribute.attribute("defer", "defer"),
              attribute.type_("module"),
              attribute.src("/static/" <> mjs),
            ],
            "",
          ),
          html.script(
            [attribute.id("hydration"), attribute.type_("application/json")],
            components |> component.encode |> json.to_string,
          ),
        ]),
        html.body([], [
          html.div([attribute.id("app")], component.render(components)),
          html.a([attribute.href(link_href)], [html.text(link_text)]),
        ]),
      ])

    wisp.html_response(element.to_document_string_builder(result), 200)
  }
}

fn middleware(
  db: database.Db,
) -> fn(wisp.Request, String, fn(wisp.Request, List(String)) -> wisp.Response) ->
  wisp.Response {
  let assert Ok(priv) = wisp.priv_directory("backend")

  let assert Ok(middleware_handler) = middleware.handler(db, True)

  fn(
    req: wisp.Request,
    tailwind_css: String,
    handle_request: fn(wisp.Request, List(String)) -> wisp.Response,
  ) {
    use <- wisp.rescue_crashes
    let req = wisp.method_override(req)
    use req <- wisp.handle_head(req)
    use session <- middleware_handler(req)

    let path_segments = wisp.path_segments(req)

    let response = case path_segments == ["static", "widgets.min.css"] {
      True ->
        wisp.response(200)
        |> wisp.set_header("Content-Type", "text/css; charset=utf-8")
        |> wisp.set_body(wisp.Text(string_tree.from_string(tailwind_css)))
      False -> {
        use <- wisp.serve_static(req, under: "/static", from: priv)

        handle_request(req, path_segments)
      }
    }

    #(response, session)
  }
}
