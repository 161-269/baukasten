import gleam/option.{type Option, None}

@external(javascript, "./widgets.ffi.mjs", "hydrationState")
pub fn hydration_state(_name: String) -> Result(Option(String), String) {
  Ok(None)
}
