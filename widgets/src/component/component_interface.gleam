import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/json.{type Json}
import lustre/element.{type Element}

pub type Component(c, a) {
  Component(
    encode: fn(c) -> Json,
    decoder: fn(Dynamic) -> Result(c, List(DecodeError)),
    render: fn(c) -> Element(a),
  )
}
