import gleam/int
import gleam/json
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string
import gleam/string_tree
import simplifile

@external(erlang, "backend_ffi", "unique_int")
fn unique_int() -> Int

const temporary_files_directory = "./tmp/tailwind"

pub type TailwindError {
  TemporaryDirectoryPermissionError(simplifile.FileError)
  TemporaryDirectoryNotFoundError(simplifile.FileError)
  CanNotCreateTemporaryDirectory(simplifile.FileError)
  CheckPathPermissionError(simplifile.FileError)
  CanNotGetCurrentWorkingDirectory(simplifile.FileError)
  CanNotFindTailwindCssCli(Option(TailwindError))
  CanNotFindNodeModules(Option(TailwindError))
  CanNotWriteTailwindConfigFile(simplifile.FileError)
  CanNotDeleteTemporaryDirectory(simplifile.FileError)
  CanNotWriteHtmlFile(simplifile.FileError)
  CanNotReadCssOutputFile(simplifile.FileError)
  CanNotStartTailwindCssCli(String)
  TailwindCssCliErrorCode(Int)
  TailwindCssCliErrorMessage(String)
}

pub type Either(a, b) {
  Left(a)
  Right(b)
}

pub fn delete_temporary_files() -> Result(Nil, TailwindError) {
  use exists <- result.try(
    simplifile.is_directory(temporary_files_directory)
    |> result.map_error(TemporaryDirectoryPermissionError),
  )

  use _ <- result.try(case exists {
    True ->
      simplifile.delete(temporary_files_directory)
      |> result.map_error(TemporaryDirectoryNotFoundError)
    False -> Ok(Nil)
  })

  simplifile.create_directory_all(temporary_files_directory)
  |> result.map_error(CanNotCreateTemporaryDirectory)
}

fn absolute_path(path: String) -> Result(String, TailwindError) {
  use cwd <- result.then(
    simplifile.current_directory()
    |> result.map_error(CanNotGetCurrentWorkingDirectory),
  )
  let path = case path {
    "/" <> _ -> path
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

  Ok(case result {
    "/" <> _ -> result
    _ -> "/" <> result
  })
}

fn find(
  prefixes: List(String),
  elements: List(String),
  is_file: Bool,
) -> Result(Option(String), TailwindError) {
  let check_path = fn(path) {
    case is_file {
      True -> simplifile.is_file
      False -> simplifile.is_directory
    }(path)
    |> result.map_error(CheckPathPermissionError)
  }

  list.fold_until(elements, Ok(None), fn(_, element) {
    let inner =
      list.fold_until(prefixes, Ok(None), fn(_, prefix) {
        let path = prefix <> element
        case absolute_path(path) {
          Ok(path) ->
            case check_path(path) {
              Ok(True) -> list.Stop(Ok(Some(path)))
              Ok(False) -> list.Continue(Ok(None))
              Error(error) -> list.Stop(Error(error))
            }
          Error(error) -> list.Stop(Error(error))
        }
      })

    case inner {
      Ok(Some(_)) | Error(_) -> list.Stop(inner)
      Ok(None) -> list.Continue(inner)
    }
  })
}

fn tailwind_css_config(
  html_directory_path: String,
  node_modules_path: String,
) -> String {
  string_tree.new()
  |> string_tree.append("module.exports = {")
  |> string_tree.append("content:")
  |> string_tree.append_tree(
    json.array([html_directory_path <> "/*.html"], json.string)
    |> json.to_string_builder,
  )
  |> string_tree.append(",daisyui:")
  |> string_tree.append_tree(
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
  |> string_tree.append(",theme:")
  |> string_tree.append_tree(
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
  |> string_tree.append(",plugins:[")
  |> string_tree.append("require(")
  |> string_tree.append_tree(
    json.string("@tailwindcss/typography") |> json.to_string_builder,
  )
  |> string_tree.append("),require(")
  |> string_tree.append_tree(
    json.string("@tailwindcss/aspect-ratio") |> json.to_string_builder,
  )
  |> string_tree.append("),require(")
  |> string_tree.append_tree(
    json.string("@tailwindcss/forms") |> json.to_string_builder,
  )
  |> string_tree.append(")({ strategy: \"class\" }")
  |> string_tree.append("),require(")
  |> string_tree.append_tree(
    json.string(node_modules_path <> "/daisyui") |> json.to_string_builder,
  )
  |> string_tree.append("),require(")
  |> string_tree.append_tree(
    json.string(node_modules_path <> "/tailwindcss-motion")
    |> json.to_string_builder,
  )
  |> string_tree.append(")]};")
  |> string_tree.to_string
}

pub type Environment {
  Environment(
    temporary_path: String,
    tailwind_css_cli_path: String,
    tailwind_css_config_path: String,
    css_output_path: String,
  )
}

pub type EnvironmentConstructor =
  fn() -> Result(Environment, TailwindError)

pub fn setup_environment() -> Result(EnvironmentConstructor, TailwindError) {
  use temporary_path <- result.try(absolute_path(temporary_files_directory))

  use tailwind_css_cli_path <- result.try(
    find(["./", "../"], ["tailwind-css-cli", "tailwind-css-cli.exe"], True)
    |> result.map_error(fn(error) { CanNotFindTailwindCssCli(Some(error)) }),
  )

  use tailwind_css_cli_path <- result.try(case tailwind_css_cli_path {
    None -> Error(CanNotFindTailwindCssCli(None))
    Some(tailwind_css_cli_path) -> Ok(tailwind_css_cli_path)
  })

  use node_modules_path <- result.try(
    find(["./", "../"], ["node_modules"], False)
    |> result.map_error(fn(error) { CanNotFindNodeModules(Some(error)) }),
  )

  use node_modules_path <- result.try(case node_modules_path {
    None -> Error(CanNotFindNodeModules(None))
    Some(node_modules_path) -> Ok(node_modules_path)
  })

  fn() -> Result(Environment, TailwindError) {
    let temporary_path = temporary_path <> "/" <> int.to_string(unique_int())
    let tailwind_css_config_path = temporary_path <> "/tailwind.config.js"
    let css_output_path = temporary_path <> "/output.css"

    use _ <- result.then(
      simplifile.create_directory_all(temporary_path)
      |> result.map_error(CanNotCreateTemporaryDirectory),
    )

    use _ <- result.then(
      simplifile.write(
        tailwind_css_config_path,
        tailwind_css_config(temporary_path, node_modules_path),
      )
      |> result.map_error(CanNotWriteTailwindConfigFile),
    )

    Ok(Environment(
      temporary_path:,
      tailwind_css_cli_path:,
      tailwind_css_config_path:,
      css_output_path:,
    ))
  }
  |> Ok
}

pub fn destruct_environment(
  environment: Environment,
) -> Result(Nil, TailwindError) {
  case simplifile.is_directory(environment.temporary_path) {
    Ok(True) -> {
      let _ =
        simplifile.delete(environment.temporary_path)
        |> result.map_error(CanNotDeleteTemporaryDirectory)
    }
    Ok(False) -> Ok(Nil)
    Error(error) -> Error(CanNotDeleteTemporaryDirectory(error))
  }
}
