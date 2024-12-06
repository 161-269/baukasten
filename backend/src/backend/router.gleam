import backend/database.{type Db}
import backend/middleware
import backend/page/default
import backend/page/initial_user
import backend/router/internal
import backend/tailwind.{type Tailwind}
import birl
import gleam/bit_array
import gleam/crypto
import gleam/erlang/process.{type Timer}
import gleam/int
import gleam/io
import gleam/result
import gleam/string_tree
import wisp.{type Request, type Response}

pub type Configuration {
  Configuration(
    db: Db,
    tailwind: Tailwind,
    dev_mode: Bool,
    restart: fn(Int) -> Timer,
  )
}

pub fn handler(cfg: Configuration) -> Result(fn(Request) -> Response, Nil) {
  use <- setup_check(cfg)
  use middleware <- result.try(
    middleware.handler(cfg.db, cfg.tailwind, cfg.dev_mode)
    |> result.map_error(fn(_) {
      io.println_error("Could not create middleware handler")
    }),
  )

  use priv <- result.try(
    wisp.priv_directory("backend")
    |> result.map_error(fn(_) {
      io.println_error("Could not get priv directory")
    }),
  )

  let internal_router = internal.route(cfg.db, cfg.tailwind)

  let default_page = default.page(cfg.tailwind)

  fn(req: Request) -> Response {
    use session, path <- middleware(req)

    case path {
      ["static", ..] -> {
        use <- wisp.serve_static(req, under: "/static", from: priv)
        default_page(req)
      }

      ["style.css"] ->
        wisp.response(200)
        |> wisp.set_header("content-type", "text/css; charset=utf-8")
        |> wisp.set_body(wisp.Text(
          tailwind.get_style(cfg.tailwind) |> string_tree.from_string,
        ))

      ["favicon.ico"] ->
        wisp.ok() |> wisp.set_body(wisp.File(priv <> "/favicon.ico"))

      ["_", ..rest] -> internal_router(req, rest, session)

      _ -> default_page(req)
    }
  }
  |> Ok
}

fn setup_check(
  cfg: Configuration,
  next: fn() -> Result(fn(Request) -> Response, Nil),
) -> Result(fn(Request) -> Response, Nil) {
  use user_count <- result.try({
    use conn <- database.connection(cfg.db, 1000, fn(_) { Nil })

    conn.stmts.user.count() |> result.map_error(fn(_) { Nil })
  })

  use <-
    fn(setup) {
      case user_count {
        0 -> setup()
        _ -> next()
      }
    }

  use initial_password <- result.try({
    use conn <- database.connection(cfg.db, 1000, fn(_) { Nil })
    {
      use <- conn.stmts.config.get_or_set("general.setup_password")
      let now = birl.now() |> birl.to_unix_micro

      let value =
        crypto.strong_random_bytes(224 / 8)
        |> bit_array.append(<<int.to_string(now):utf8>>)
        |> crypto.hash(crypto.Sha224, _)
        |> bit_array.base16_encode

      #(value, now)
    }
    |> result.map_error(fn(_) { Nil })
  })

  let initial_user_page =
    initial_user.page(cfg.tailwind, cfg.db, initial_password.value, cfg.restart)

  fn(req: Request) -> Response { initial_user_page(req) } |> Ok
}
