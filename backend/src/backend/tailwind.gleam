import gleam/int
import gleam/io
import gleam/json
import gleam/list.{Continue, Stop}
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string
import gleam/string_builder
import simplifile

@external(erlang, "backend_ffi", "generate_css")
fn generate_css(
  cailwind_css_cli_path: List(String),
  config_path: String,
  output_css_path: String,
  timeout_ms: Int,
) -> Result(String, String)

@external(erlang, "backend_ffi", "unique_int")
fn unique_int() -> Int

const temporary_files_directory = "./tmp/tailwind"

pub type TailwindError {
  TemporaryDirectoryPermissionError(simplifile.FileError)
  TemporaryDirectoryNotFoundError(simplifile.FileError)
  CouldNotCreateTemporaryDirectory(simplifile.FileError)
  CouldNotGetTempraryAbsolutePath(simplifile.FileError)
  CanNotFindTailwindCssCli
  ErrorFindingTailwindCssCli(simplifile.FileError)
  CanNotFindNodeModules
  ErrorFindingNodeModules(simplifile.FileError)
  CouldNotCreateUniqueTemporaryDirectory(simplifile.FileError)
  CouldNotDeleteUniqueTemporaryDirectory(simplifile.FileError)
  CouldNotWriteHtmlFile(simplifile.FileError)
  CouldNotWriteTailwindConfigFile(simplifile.FileError)
  CouldNotGenerateCss(String)
  CouldNotReadCssOutputFile(simplifile.FileError)
}

pub fn delete_temporary_files() -> Result(Nil, TailwindError) {
  use _ <- result.then(case simplifile.is_directory(temporary_files_directory) {
    Ok(exists) ->
      case exists {
        True ->
          simplifile.delete(temporary_files_directory)
          |> result.map_error(TemporaryDirectoryNotFoundError)
        False -> Ok(Nil)
      }
    Error(error) -> Error(TemporaryDirectoryPermissionError(error))
  })

  simplifile.create_directory_all(temporary_files_directory)
  |> result.map_error(CouldNotCreateTemporaryDirectory)
}

fn find(
  prefixes: List(String),
  elements: List(String),
  is_file: Bool,
) -> Result(Option(String), simplifile.FileError) {
  list.fold_until(elements, Ok(None), fn(_, element) {
    case
      list.fold_until(prefixes, Ok(None), fn(_, prefix) {
        let func = case is_file {
          True -> simplifile.is_file
          False -> simplifile.is_directory
        }

        let path = prefix <> element
        case abolute_path(path) {
          Ok(path) ->
            case func(path) {
              Ok(True) -> Stop(Ok(Some(path)))
              Ok(False) -> Continue(Ok(None))
              Error(error) -> Stop(Error(error))
            }
          Error(error) -> Stop(Error(error))
        }
      })
    {
      Ok(Some(path)) -> Stop(Ok(Some(path)))
      Ok(None) -> Continue(Ok(None))
      Error(error) -> Stop(Error(error))
    }
  })
}

fn tailwind_css_config(
  html_directory_path: String,
  node_modules_path: String,
) -> String {
  string_builder.new()
  |> string_builder.append("module.exports = {")
  |> string_builder.append("content:")
  |> string_builder.append_builder(
    json.array([html_directory_path <> "/*.html"], json.string)
    |> json.to_string_builder,
  )
  |> string_builder.append(",daisyui:")
  |> string_builder.append_builder(
    json.object([
      #(
        "themes",
        json.array(
          [
            [
              #(
                "light",
                json.object([
                  #("colorScheme", json.string("light")),
                  #("primary", json.string("oklch(49.12% 0.3096 275.75)")),
                  #("secondary", json.string("oklch(69.71% 0.329 342.55)")),
                  #(
                    "secondary-content",
                    json.string("oklch(98.71% 0.0106 342.55)"),
                  ),
                  #("accent", json.string("oklch(76.76% 0.184 183.61)")),
                  #("neutral", json.string("#2B3440")),
                  #("neutral-content", json.string("#D7DDE4")),
                  #("base-100", json.string("oklch(100% 0 0)")),
                  #("base-200", json.string("#F2F2F2")),
                  #("base-300", json.string("#E5E6E6")),
                  #("base-content", json.string("#1f2937")),
                  #("--rounded-box", json.string("1rem")),
                  #("--rounded-btn", json.string("0.5rem")),
                  #("--rounded-badge", json.string("1.9rem")),
                  #("--animation-btn", json.string("0.25s")),
                  #("--animation-input", json.string("0.2s")),
                  #("--btn-focus-scale", json.string("0.95")),
                  #("--border-btn", json.string("1px")),
                  #("--tab-border", json.string("1px")),
                  #("--tab-radius", json.string("0.5rem")),
                ]),
              ),
              #(
                "dark",
                json.object([
                  #("colorScheme", json.string("dark")),
                  #("primary", json.string("oklch(65.69% 0.196 275.75)")),
                  #("secondary", json.string("oklch(74.8% 0.26 342.55)")),
                  #("accent", json.string("oklch(74.51% 0.167 183.61)")),
                  #("neutral", json.string("#2a323c")),
                  #("neutral-content", json.string("#A6ADBB")),
                  #("base-100", json.string("#1d232a")),
                  #("base-200", json.string("#191e24")),
                  #("base-300", json.string("#15191e")),
                  #("base-content", json.string("#A6ADBB")),
                  #("--rounded-box", json.string("1rem")),
                  #("--rounded-btn", json.string("0.5rem")),
                  #("--rounded-badge", json.string("1.9rem")),
                  #("--animation-btn", json.string("0.25s")),
                  #("--animation-input", json.string("0.2s")),
                  #("--btn-focus-scale", json.string("0.95")),
                  #("--border-btn", json.string("1px")),
                  #("--tab-border", json.string("1px")),
                  #("--tab-radius", json.string("0.5rem")),
                ]),
              ),
            ],
          ],
          json.object,
        ),
      ),
      #("darkTheme", json.string("dark")),
      #("base", json.bool(True)),
      #("styled", json.bool(True)),
      #("utils", json.bool(True)),
      #("prefix", json.string("")),
      #("logs", json.bool(True)),
      #("themeRoot", json.string(":root")),
    ])
    |> json.to_string_builder,
  )
  |> string_builder.append(",theme:")
  |> string_builder.append_builder(
    json.object([
      #(
        "extend",
        json.object([
          #(
            "fontFamily",
            json.object([
              #(
                "sans",
                json.array(
                  [
                    "\"Source Sans 3\"", "ui-sans-serif", "system-ui",
                    "sans-serif", "\"Apple Color Emoji\"", "\"Segoe UI Emoji\"",
                    "\"Segoe UI Symbol\"", "\"Noto Color Emoji\"",
                  ],
                  json.string,
                ),
              ),
              #(
                "serif",
                json.array(
                  [
                    "\"Source Serif 4\"", "ui-serif", "Georgia", "Cambria",
                    "\"Times New Roman\"", "Times", "serif",
                  ],
                  json.string,
                ),
              ),
              #(
                "mono",
                json.array(
                  [
                    "\"Source Code Pro\"", "ui-monospace", "SFMono-Regular",
                    "Menlo", "Monaco", "Consolas", "\"Liberation Mono\"",
                    "\"Courier New\"", "monospace",
                  ],
                  json.string,
                ),
              ),
            ]),
          ),
        ]),
      ),
    ])
    |> json.to_string_builder,
  )
  |> string_builder.append(",plugins:[")
  |> string_builder.append("require(")
  |> string_builder.append_builder(
    json.string("@tailwindcss/typography") |> json.to_string_builder,
  )
  |> string_builder.append("),require(")
  |> string_builder.append_builder(
    json.string("@tailwindcss/aspect-ratio") |> json.to_string_builder,
  )
  |> string_builder.append("),require(")
  |> string_builder.append_builder(
    json.string(node_modules_path <> "/daisyui") |> json.to_string_builder,
  )
  |> string_builder.append("),require(")
  |> string_builder.append_builder(
    json.string(node_modules_path <> "/tailwindcss-motion")
    |> json.to_string_builder,
  )
  |> string_builder.append(")]};")
  |> string_builder.to_string
}

pub fn generate_css_for() -> fn(List(String)) -> Result(String, TailwindError) {
  let requirements =
    abolute_path(temporary_files_directory)
    |> result.map_error(CouldNotGetTempraryAbsolutePath)
    |> result.then(fn(temporary_path) {
      find(["./", "../"], ["tailwind-css-cli", "tailwind-css-cli.exe"], True)
      |> result.map_error(ErrorFindingTailwindCssCli)
      |> result.then(fn(tailwind_css_cli_path) {
        case tailwind_css_cli_path {
          None -> Error(CanNotFindTailwindCssCli)
          Some(tailwind_css_cli_path) ->
            find(["./", "../"], ["node_modules"], False)
            |> result.map_error(ErrorFindingNodeModules)
            |> result.then(fn(node_modules_path) {
              case node_modules_path {
                None -> Error(CanNotFindNodeModules)
                Some(node_modules_path) ->
                  Ok(#(temporary_path, tailwind_css_cli_path, node_modules_path))
              }
            })
        }
      })
    })

  fn(html: List(String)) {
    use #(temporary_path, tailwind_css_cli_path, node_modules_path) <- result.then(
      requirements,
    )
    let temporary_path = temporary_path <> "/" <> int.to_string(unique_int())
    let tailwind_css_config_path = temporary_path <> "/tailwind.config.js"
    let css_output_path = temporary_path <> "/output.css"

    use _ <- result.then(
      simplifile.create_directory_all(temporary_path)
      |> result.map_error(CouldNotCreateUniqueTemporaryDirectory),
    )

    let result =
      fn() {
        use _ <- result.then(
          list.fold_until(html, Ok(0), fn(index, html) {
            case index {
              Ok(index) -> {
                case
                  simplifile.write(
                    temporary_path <> "/" <> int.to_string(index) <> ".html",
                    html,
                  )
                {
                  Ok(_) -> Continue(Ok(index + 1))
                  Error(error) -> Stop(Error(CouldNotWriteHtmlFile(error)))
                }
              }
              Error(error) -> Stop(Error(error))
            }
          }),
        )

        use _ <- result.then(
          simplifile.write(
            tailwind_css_config_path,
            tailwind_css_config(temporary_path, node_modules_path),
          )
          |> result.map_error(CouldNotWriteTailwindConfigFile),
        )

        use log <- result.then(
          generate_css(
            [tailwind_css_cli_path],
            tailwind_css_config_path,
            css_output_path,
            30_000,
          )
          |> result.map_error(CouldNotGenerateCss),
        )

        io.println(log)

        simplifile.read(css_output_path)
        |> result.map_error(CouldNotReadCssOutputFile)
      }()

    let delete_result =
      simplifile.delete(temporary_path)
      |> result.map_error(CouldNotDeleteUniqueTemporaryDirectory)

    result.then(result, fn(result) {
      delete_result |> result.map(fn(_) { result })
    })
  }
}

fn abolute_path(path: String) -> Result(String, simplifile.FileError) {
  use cwd <- result.then(simplifile.current_directory())
  let path = case string.slice(path, 0, 1) {
    "/" -> path
    _ -> cwd <> "/" <> path
  }
  let result =
    path
    |> string.replace("\\", "/")
    |> string.split("/")
    |> list.fold([], fn(acc, part) {
      case part {
        "" | "." -> acc
        ".." -> {
          let #(acc, _) = list.split(acc, list.length(acc) - 1)
          acc
        }
        _ -> list.append(acc, [part])
      }
    })
    |> string.join("/")

  Ok(case string.slice(path, 0, 1) {
    "/" -> "/" <> result
    _ -> result
  })
}
