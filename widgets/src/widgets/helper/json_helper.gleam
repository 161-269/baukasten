import gleam/int
import gleam/json
import gleam/list
import gleam/string
import widgets/helper/dynamic_helper

pub fn stringify_decode_error(decode_error: json.DecodeError) -> String {
  case decode_error {
    json.UnexpectedByte(byte, position) ->
      "unexpected byte " <> byte <> " at " <> int.to_string(position)
    json.UnexpectedEndOfInput -> "unexpected end of input"
    json.UnexpectedFormat(errors) ->
      "unexpected format: "
      <> list.map(errors, dynamic_helper.stringify_decode_error)
      |> string.join(", ")
    json.UnexpectedSequence(byte, position) ->
      "unexpected sequence " <> byte <> " at " <> int.to_string(position)
  }
}
