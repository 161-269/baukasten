import backend/database.{type Db}
import backend/tailwind/build.{type Tailwind}
import gleam/erlang/process.{type Timer}
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import gleam/string_tree
import lustre/attribute
import lustre/element
import lustre/element/html
import wisp.{type Request, type Response}

pub fn page(
  tailwind: Tailwind,
  db: Db,
  initial_password: String,
  restart: fn(Int) -> Timer,
) -> fn(Request) -> Response {
  let initial_password_message = [
    "",
    "==============================================================",
    "",
    "Hello and welcome to Baukasten!",
    "",
    "To get started, you need the setup key.",
    "You can enter it in the web interface to create an admin user.",
    "",
    "The setup key is:",
    initial_password,
    "",
    "==============================================================",
    "",
  ]

  list.map(initial_password_message, io.println)
  list.map(initial_password_message, io.println_error)

  let assert Ok(priv) = wisp.priv_directory("backend")

  let form = form_page(tailwind)

  fn(req: Request) -> Response {
    case wisp.path_segments(req) {
      ["style.css"] -> {
        wisp.response(200)
        |> wisp.set_header("content-type", "text/css; charset=utf-8")
        |> wisp.set_body(
          wisp.Text(string_tree.from_string(build.get_style(tailwind))),
        )
      }
      ["static", ..] -> {
        use <- wisp.serve_static(req, under: "/static", from: priv)

        wisp.not_found()
      }

      ["favicon.ico"] ->
        wisp.ok() |> wisp.set_body(wisp.File(priv <> "/favicon.ico"))

      ["create-admin"] -> {
        use form_data <- wisp.require_form(req)

        let form_data =
          list.fold(form_data.values, new_form(), fn(acc, value) {
            let #(key, value) = value
            case key {
              "username" -> Form(..acc, username: value)
              "email" -> Form(..acc, email: value)
              "password-a" -> Form(..acc, password_a: value)
              "password-b" -> Form(..acc, password_b: value)
              "initial-password" ->
                Form(..acc, initial_password: clean_initial_password(value))
              _ -> acc
            }
          })

        let error_message = case
          form_data.initial_password == initial_password
        {
          True -> ""
          False -> "Initial password does not match."
        }

        let error_message = case
          error_message != "" || form_data.password_a == form_data.password_b
        {
          True -> error_message
          False -> "Passwords do not match."
        }

        let error_message = case error_message {
          "" ->
            case
              database.connection(db, 1000, fn(e) { e }, fn(connection) {
                connection.stmts.user.insert_new(
                  form_data.username,
                  form_data.email,
                  form_data.password_a,
                )
                |> result.map_error(database.SqlightError)
              })
            {
              Ok(_) -> ""
              Error(error) ->
                case error {
                  database.MigrationError(_) -> "Could not migrate database."
                  database.PoolStartError(_) -> "Could not start database pool."
                  database.PrivateDirectoryNotFound ->
                    "Could not find private directory."
                  database.SqlightError(error) ->
                    "SQLite error: " <> error.message
                  database.WaitForConnectionError(_) ->
                    "Could not connect to database."
                  database.WaitForConnectionTimeout(_) ->
                    "Database connection timeout."
                }
            }
          _ -> error_message
        }

        case error_message {
          "" -> {
            restart(1250)
            form(
              "User created successfully. Restarting the server ... please wait ...",
              3,
              new_form(),
            )
          }
          _ -> form(error_message, 0, form_data)
        }
      }
      _ -> form("", 0, new_form())
    }
  }
}

fn clean_initial_password(initial_password: String) -> String {
  initial_password
  |> string.uppercase
  |> string.to_graphemes
  |> list.map(fn(grapheme) {
    case grapheme {
      "0" | "O" -> "0"
      "1" | "I" | "L" -> "1"
      "2" | "Z" -> "2"
      "3" -> "3"
      "4" -> "4"
      "5" -> "5"
      "6" -> "6"
      "7" -> "7"
      "8" -> "8"
      "9" -> "9"
      "A" -> "A"
      "B" -> "B"
      "C" -> "C"
      "D" -> "D"
      "E" -> "E"
      "F" -> "F"
      _ -> ""
    }
  })
  |> string.join("")
}

type Form {
  Form(
    username: String,
    email: String,
    password_a: String,
    password_b: String,
    initial_password: String,
  )
}

fn new_form() -> Form {
  Form(
    username: "",
    email: "",
    password_a: "",
    password_b: "",
    initial_password: "",
  )
}

fn form_page(tailwind: Tailwind) -> fn(String, Int, Form) -> Response {
  let page_html = fn(error_message: String, redirect: Int, form: Form) -> String {
    html.html([attribute.attribute("lang", "en")], [
      html.head([], [
        html.meta([attribute.attribute("charset", "utf-8")]),
        case redirect > 0 {
          True ->
            html.meta([
              attribute.attribute("http-equiv", "refresh"),
              attribute.attribute(
                "content",
                int.to_string(redirect) <> "; url=/_/login",
              ),
            ])
          False -> element.none()
        },
        html.meta([
          attribute.name("viewport"),
          attribute.attribute(
            "content",
            "width=device-width, initial-scale=1.0",
          ),
        ]),
        html.title([], "Welcome to Baukasten 🛠️"),
        html.link([
          attribute.rel("stylesheet"),
          attribute.href("/static/fonts.css"),
        ]),
        html.link([attribute.rel("stylesheet"), attribute.href("/style.css")]),
      ]),
      html.body([], [
        html.div([attribute.class("grid h-screen place-items-center")], [
          html.div([attribute.class("card bg-base-200 w-96")], [
            html.div([attribute.class("card-body")], [
              html.h2(
                [
                  attribute.class(
                    "text-2xl text-center text-primary motion-preset-confetti motion-duration-[2s]",
                  ),
                ],
                [html.text("Welcome to Baukasten 🛠️")],
              ),
              html.form(
                [
                  attribute.class("w-full flex flex-col gap-2"),
                  attribute.action("/create-admin"),
                  attribute.target("_self"),
                  attribute.method("POST"),
                ],
                [
                  html.input([
                    attribute.required(True),
                    attribute.name("username"),
                    attribute.type_("text"),
                    attribute.placeholder("Username"),
                    attribute.value(form.username),
                    attribute.class("input input-bordered w-full"),
                  ]),
                  html.input([
                    attribute.required(True),
                    attribute.name("email"),
                    attribute.type_("email"),
                    attribute.placeholder("E-Mail"),
                    attribute.value(form.email),
                    attribute.class("input input-bordered w-full"),
                  ]),
                  html.input([
                    attribute.required(True),
                    attribute.name("password-a"),
                    attribute.type_("password"),
                    attribute.placeholder("Your password"),
                    attribute.class("input input-bordered w-full"),
                  ]),
                  html.input([
                    attribute.required(True),
                    attribute.name("password-b"),
                    attribute.type_("password"),
                    attribute.placeholder("Repeat password"),
                    attribute.class("input input-bordered w-full"),
                  ]),
                  html.input([
                    attribute.required(True),
                    attribute.name("initial-password"),
                    attribute.type_("text"),
                    attribute.value(form.initial_password),
                    attribute.placeholder("Setup key (from application logs)"),
                    attribute.class("input input-bordered w-full"),
                  ]),
                  html.input([
                    attribute.name("submit"),
                    attribute.type_("submit"),
                    attribute.class("btn btn-primary text-lg w-full"),
                    attribute.value("Create new admin user"),
                  ]),
                  html.div(
                    [attribute.class("text-lg text-center text-error w-full")],
                    [html.text(error_message)],
                  ),
                ],
              ),
            ]),
          ]),
        ]),
      ]),
    ])
    |> element.to_document_string
  }

  build.add_html(tailwind, page_html("", 0, new_form()))

  fn(error_message: String, redirect: Int, form: Form) {
    wisp.html_response(
      string_tree.from_string(page_html(error_message, redirect, form)),
      200,
    )
  }
}
