import gleam/dynamic
import gleam/list
import gleam/result
import gleam/string
import gleam/string_builder

pub fn stringify_decode_error(decode_error: dynamic.DecodeError) -> String {
  string_builder.from_strings([
    "expected ",
    decode_error.expected,
    " but found ",
    decode_error.found,
    " at ",
    list.map(decode_error.path, fn(i) { "\"" <> i <> "\"" })
      |> string.join(", "),
  ])
  |> string_builder.to_string()
}

pub fn map(
  decoder: fn(dynamic.Dynamic) -> Result(a, List(dynamic.DecodeError)),
  with: fn(a) -> Result(b, List(dynamic.DecodeError)),
) -> fn(dynamic.Dynamic) -> Result(b, List(dynamic.DecodeError)) {
  fn(value: dynamic.Dynamic) {
    decoder(value)
    |> result.then(with)
  }
}

pub fn flatten(
  decoder: fn(dynamic.Dynamic) ->
    Result(Result(a, List(dynamic.DecodeError)), List(dynamic.DecodeError)),
) -> fn(dynamic.Dynamic) -> Result(a, List(dynamic.DecodeError)) {
  fn(value: dynamic.Dynamic) {
    decoder(value)
    |> result.flatten
  }
}
