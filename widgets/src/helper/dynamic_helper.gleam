import gleam/dynamic
import gleam/result

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
