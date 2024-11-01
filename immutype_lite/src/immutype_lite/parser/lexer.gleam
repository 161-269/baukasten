//// https://www.sqlite.org/lang.html

import chomp/lexer.{type Lexer, type Matcher}
import gleam/list
import gleam/string
import immutype_lite/parser/helper
import immutype_lite/parser/lexer/keyword.{type Keyword}

pub type Speacial {
  Semicolon
  Comma
  Dot
  LeftParen
  RightParen
  Star
}

pub fn stringify_special(special: Speacial) -> String {
  case special {
    Semicolon -> ";"
    Comma -> ","
    Dot -> "."
    LeftParen -> "("
    RightParen -> ")"
    Star -> "*"
  }
}

pub type Operator {
  Equals
}

pub fn stringify_operator(operator: Operator) -> String {
  case operator {
    Equals -> "="
  }
}

pub type Token {
  Operator(Operator)
  Special(Speacial)
  Comment(String)
  Metadata(key: String, value: String)
  MacroDefinition(key: String, value: String)
  StringLiteral(String)
  Keyword(Keyword)
  Identifier(String)
  Whitespace(lines: Int)
}

pub fn lexer() -> Lexer(Token, Nil) {
  let operators = operators()
  let specials = specials()
  let comments = comments()
  let number_literals = number_literals()
  let string_literals = string_literals()
  let keywords = keyword.keyword_mathers(Keyword)
  let identifiers = identifiers()

  lexer.simple(
    list.flatten([
      operators,
      specials,
      comments,
      number_literals,
      string_literals,
      keywords,
      identifiers,
      [
        helper.regex_matcher("^\\s+", "[^\\s]", fn(whitespace) {
          Whitespace(
            list.fold(string.to_graphemes(whitespace), 0, fn(acc, char) {
              case char {
                "\n" -> acc + 1
                _ -> acc
              }
            }),
          )
        }),
      ],
    ]),
  )
}

fn specials() -> List(Matcher(Token, a)) {
  [
    #(";", Semicolon),
    #(",", Comma),
    #(".", Dot),
    #("(", LeftParen),
    #(")", RightParen),
    #("*", Star),
  ]
  |> list.map(fn(tuple) {
    let #(token, value) = tuple
    lexer.token(token, Special(value))
  })
}

fn operators() -> List(Matcher(Token, a)) {
  [#("=", Equals)]
  |> list.map(fn(tuple) {
    let #(token, value) = tuple
    lexer.token(token, Operator(value))
  })
}

fn new_metadata(input: String) -> Token {
  let input =
    input
    |> string.drop_left(7)
    |> string.trim

  case string.split_once(input, " ") {
    Ok(#(key, value)) ->
      MacroDefinition(string.trim_right(key), string.trim_left(value))
    Error(_) -> MacroDefinition("", input)
  }
}

fn new_macro_definition(input: String) -> Token {
  let input =
    input
    |> string.drop_left(8)
    |> string.trim

  case string.split_once(input, " ") {
    Ok(#(key, value)) ->
      MacroDefinition(string.trim_right(key), string.trim_left(value))
    Error(_) -> MacroDefinition("", input)
  }
}

fn comments() -> List(Matcher(Token, a)) {
  [
    helper.regex_matcher("^---\\s*\\w+\\s*:\\s*\\w+\\s*", "\n", new_metadata),
    helper.regex_matcher("^--([^-].*)?", "\n", fn(input) {
      Comment(string.drop_left(input, 2))
    }),
    helper.regex_matcher("^\\/\\*[\\s\\S]*?\\*\\/", "", fn(input) {
      Comment(input |> string.drop_left(2) |> string.drop_right(2))
    }),
    helper.regex_matcher("^#(?!define\\s).*", "\n", fn(input) {
      Comment(input |> string.drop_left(1))
    }),
    helper.regex_matcher(
      "^#define\\s+\\w+\\s* \\s*\\w+\\s*",
      "\n",
      new_macro_definition,
    ),
  ]
}

fn identifiers() -> List(Matcher(Token, a)) {
  [
    helper.regex_matcher("^[\\w_][\\w_\\d]*", helper.breaker_regex, fn(input) {
      Identifier(input)
    }),
    helper.regex_matcher(
      "^\"(?:\"\"|[^\"])*(?!\"\")\"",
      helper.breaker_regex,
      fn(input) {
        Identifier(input |> string.drop_left(1) |> string.drop_right(1))
      },
    ),
    helper.regex_matcher("^\\[[^\\]]*\\]", helper.breaker_regex, fn(input) {
      Identifier(input |> string.drop_left(1) |> string.drop_right(1))
    }),
    helper.regex_matcher("^`[^`]*`", helper.breaker_regex, fn(input) {
      Identifier(input |> string.drop_left(1) |> string.drop_right(1))
    }),
  ]
}

fn string_literals() -> List(Matcher(Token, a)) {
  [
    helper.regex_matcher(
      "^'(?:''|[^'])*(?!'')'",
      helper.breaker_regex,
      fn(input) {
        StringLiteral(input |> string.drop_left(1) |> string.drop_right(1))
      },
    ),
  ]
}

fn number_literals() -> List(Matcher(Token, a)) {
  []
}
