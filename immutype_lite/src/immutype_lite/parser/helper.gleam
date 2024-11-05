import chomp/lexer.{type Matcher, Keep, NoMatch}
import gleam/list
import gleam/regex

pub const breaker_regex = "[;\\,\\.\\(\\)\\~\\+\\-\\|\\*\\/\\%\\&\\<\\>\\=\\!\\s]"

pub fn regex_matcher(
  pattern: String,
  lookahead_pattern: String,
  value: fn(String) -> a,
) -> Matcher(a, mode) {
  let assert Ok(regex) = regex.from_string(pattern)
  let lookahead_check = lookahead_check(lookahead_pattern)

  use mode, lexeme, lookahead <- lexer.custom
  case lookahead_check(lookahead) && regex.check(regex, lexeme) {
    True -> Keep(value(lexeme), mode)
    False -> NoMatch
  }
}

pub fn complex_matcher(
  match: fn(String) -> Bool,
  lookahead_pattern: String,
  value: fn(String) -> a,
) {
  let lookahead_check = lookahead_check(lookahead_pattern)

  use mode, lexeme, lookahead <- lexer.custom
  case lookahead_check(lookahead) && match(lexeme) {
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

pub fn exact(
  pattern: String,
  negative_lookahead: List(String),
  value: a,
) -> Matcher(a, mode) {
  case negative_lookahead {
    [] -> {
      use mode, lexeme, _ <- lexer.custom
      case lexeme == pattern {
        True -> Keep(value, mode)
        False -> NoMatch
      }
    }
    _ -> {
      use mode, lexeme, lookahead <- lexer.custom
      case
        lexeme == pattern
        && {
          lookahead == ""
          || list.all(negative_lookahead, fn(negative_lookahead) {
            negative_lookahead != lookahead
          })
        }
      {
        True -> Keep(value, mode)
        False -> NoMatch
      }
    }
  }
}
