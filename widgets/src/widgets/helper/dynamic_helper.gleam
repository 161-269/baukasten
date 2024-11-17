import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string
import gleam/string_tree

pub fn stringify_decode_error(decode_error: DecodeError) -> String {
  string_tree.from_strings([
    "expected ",
    decode_error.expected,
    " but found ",
    decode_error.found,
    " at ",
    list.map(decode_error.path, fn(i) { "\"" <> i <> "\"" })
      |> string.join(", "),
  ])
  |> string_tree.to_string()
}

pub fn map(
  decoder: fn(Dynamic) -> Result(a, List(DecodeError)),
  with: fn(a) -> Result(b, List(DecodeError)),
) -> fn(Dynamic) -> Result(b, List(DecodeError)) {
  fn(value: Dynamic) {
    decoder(value)
    |> result.then(with)
  }
}

pub fn flatten(
  decoder: fn(Dynamic) ->
    Result(Result(a, List(DecodeError)), List(DecodeError)),
) -> fn(Dynamic) -> Result(a, List(DecodeError)) {
  fn(value: Dynamic) {
    decoder(value)
    |> result.flatten
  }
}

pub fn prepend_error(
  decoder: fn(Dynamic) -> Result(a, List(DecodeError)),
  error: DecodeError,
) -> fn(Dynamic) -> Result(a, List(DecodeError)) {
  fn(value: Dynamic) {
    decoder(value)
    |> result.map_error(fn(errors) { [error, ..errors] })
  }
}

pub fn decode_nullable_mapped_string_field(
  field: String,
  map_with: fn(String) -> Result(a, List(DecodeError)),
) -> fn(Dynamic) -> Result(Option(a), List(DecodeError)) {
  dynamic.field(
    field,
    dynamic.optional(dynamic.string)
      |> map(fn(value: Option(String)) {
        case value {
          Some(value) -> map_with(value) |> result.map(Some)
          None -> Ok(None)
        }
      }),
  )
}
