import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute}

pub fn classify(attributes: List(Option(String))) -> List(Attribute(a)) {
  list.filter_map(attributes, fn(attribute: Option(String)) {
    case attribute {
      Some(attribute) -> Ok(attribute.class(attribute))
      None -> Error(Nil)
    }
  })
}
