import backend/page/layout
import backend/tailwind/build.{type Tailwind}
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import wisp.{type Response}

pub fn page(
  tailwind: Tailwind,
  title_prefix: String,
  title_suffix: String,
) -> fn(String, String) -> Response {
  let title = title_prefix <> "Login" <> title_suffix

  let layout = layout.minimal()

  let default_body = body("/login", "")
  let html = layout(title, [], default_body) |> element.to_document_string()

  build.add_html(tailwind, html)

  fn(path: String, error: String) -> Response {
    body(path, error)
    |> layout(title, [], _)
    |> element.to_document_string_builder()
    |> wisp.html_response(200)
  }
}

fn body(path: String, error: String) -> List(Element(a)) {
  [
    html.div([attribute.class("grid h-screen place-items-center")], [
      html.div([attribute.class("card bg-base-200 w-96")], [
        html.div([attribute.class("card-body")], [
          html.h2(
            [
              attribute.class(
                "text-2xl text-center text-primary motion-preset-confetti motion-duration-[2s]",
              ),
            ],
            [html.text("Login")],
          ),
          html.form(
            [
              attribute.class("w-full flex flex-col gap-2"),
              attribute.action(path),
              attribute.target("_self"),
              attribute.method("POST"),
            ],
            [
              html.input([
                attribute.required(True),
                attribute.name("username"),
                attribute.type_("text"),
                attribute.placeholder("Username or email"),
                attribute.class("input input-bordered w-full"),
              ]),
              html.input([
                attribute.required(True),
                attribute.name("password"),
                attribute.type_("password"),
                attribute.placeholder("Password"),
                attribute.class("input input-bordered w-full"),
              ]),
              html.input([
                attribute.name("submit"),
                attribute.type_("submit"),
                attribute.class("btn btn-primary text-lg w-full"),
                attribute.value("Login"),
              ]),
              html.div(
                [attribute.class("text-lg text-center text-error w-full")],
                [html.text(error)],
              ),
            ],
          ),
        ]),
      ]),
    ]),
  ]
}
