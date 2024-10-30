import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/option.{type Option}
import sqlight

pub type Encoder(t) =
  fn(t) -> sqlight.Value

pub type Decoder(t) =
  fn(Dynamic) -> Result(t, List(DecodeError))

pub type Type(base_type, value_type) {
  Type(
    name: String,
    base_encoder: Encoder(base_type),
    base_decoder: Decoder(base_type),
    value_encoder: Encoder(value_type),
    value_decoder: Decoder(value_type),
  )
}

pub fn new(name: String, encoder: Encoder(a), decoder: Decoder(a)) -> Type(a, a) {
  Type(
    name: name,
    base_encoder: encoder,
    base_decoder: decoder,
    value_encoder: encoder,
    value_decoder: decoder,
  )
}

pub fn new_nullable(
  name: String,
  encoder: Encoder(a),
  decoder: Decoder(a),
) -> Type(a, Option(a)) {
  Type(
    name: name,
    base_encoder: encoder,
    base_decoder: decoder,
    value_encoder: fn(value: Option(a)) { sqlight.nullable(encoder, value) },
    value_decoder: dynamic.optional(decoder),
  )
}

pub fn integer() -> Type(Int, Int) {
  new("INTEGER NOT NULL", sqlight.int, dynamic.int)
}

pub fn nullable_integer() -> Type(Int, Option(Int)) {
  new_nullable("INTEGER", sqlight.int, dynamic.int)
}

pub fn real() -> Type(Float, Float) {
  new("REAL NOT NULL", sqlight.float, dynamic.float)
}

pub fn nullable_real() -> Type(Float, Option(Float)) {
  new_nullable("REAL", sqlight.float, dynamic.float)
}

pub fn text() -> Type(String, String) {
  new("TEXT NOT NULL", sqlight.text, dynamic.string)
}

pub fn nullable_text() -> Type(String, Option(String)) {
  new_nullable("TEXT NOT NULL", sqlight.text, dynamic.string)
}

pub fn blob() -> Type(BitArray, BitArray) {
  new("BLOB NOT NULL", sqlight.blob, dynamic.bit_array)
}

pub fn nullable_blob() -> Type(BitArray, Option(BitArray)) {
  new_nullable("BLOB", sqlight.blob, dynamic.bit_array)
}

pub fn bool() -> Type(Bool, Bool) {
  new(integer().name, bool_encoder, bool_decoder)
}

pub fn nullable_bool() -> Type(Bool, Option(Bool)) {
  new_nullable(nullable_integer().name, bool_encoder, bool_decoder)
}

fn bool_encoder(value: Bool) -> sqlight.Value {
  case value {
    True -> sqlight.int(1)
    False -> sqlight.int(0)
  }
}

pub fn bool_decoder(value: Dynamic) -> Result(Bool, List(DecodeError)) {
  case dynamic.int(value) {
    Ok(0) -> Ok(False)
    Ok(_) -> Ok(True)
    Error(error) -> Error(error)
  }
}
