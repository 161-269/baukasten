import chomp/lexer.{type Matcher, Keep, NoMatch}
import gleam/regex

pub const breaker_regex = "[;\\,\\.\\(\\)\\*\\s]"

pub fn regex_matcher(
  pattern: String,
  lookahead_pattern: String,
  value: fn(String) -> a,
) -> Matcher(a, mode) {
  let assert Ok(regex) = regex.from_string(pattern)
  let lookahead_check = lookahead_check(lookahead_pattern)

  use mode, lexeme, lookahead <- lexer.custom
  case regex.check(regex, lexeme) && lookahead_check(lookahead) {
    True -> Keep(value(lexeme), mode)
    False -> NoMatch
  }
}

fn lookahead_check(pattern: String) -> fn(String) -> Bool {
  case pattern == "" {
    True -> fn(_) { True }
    False -> {
      let assert Ok(regex) = regex.from_string(pattern)
      fn(lookahead) { lookahead == "" || regex.check(regex, lookahead) }
    }
  }
}
