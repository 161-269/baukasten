//// https://www.sqlite.org/lang.html

import chomp/lexer.{type Lexer, type Matcher}
import gleam/int
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
}

pub fn stringify_special(special: Speacial) -> String {
  case special {
    Semicolon -> ";"
    Comma -> ","
    Dot -> "."
    LeftParen -> "("
    RightParen -> ")"
  }
}

/// https://www.sqlite.org/lang_expr.html
pub type Operator {
  Tilda
  Plus
  Minus
  LogicalOr
  ExtractText
  ExtractParsed
  Multiply
  Divide
  Modulo
  BinaryAnd
  BinaryOr
  ShiftLeft
  ShiftRight
  LessThan
  GreaterThan
  LessThanOrEqual
  GreaterThanOrEqual
  Equals
  EqualsEquals
  LessOrGreaterThan
  NotEquals
}

pub fn stringify_operator(operator: Operator) -> String {
  case operator {
    Tilda -> "~"
    Plus -> "+"
    Minus -> "-"
    LogicalOr -> "||"
    ExtractText -> "->"
    ExtractParsed -> "->>"
    Multiply -> "*"
    Divide -> "/"
    Modulo -> "%"
    BinaryAnd -> "&"
    BinaryOr -> "|"
    ShiftLeft -> "<<"
    ShiftRight -> ">>"
    LessThan -> "<"
    GreaterThan -> ">"
    LessThanOrEqual -> "<="
    GreaterThanOrEqual -> ">="
    Equals -> "="
    EqualsEquals -> "=="
    LessOrGreaterThan -> "<>"
    NotEquals -> "!="
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

pub fn stringify_token(token: Token) -> String {
  case token {
    Operator(operator) -> "Operator(" <> stringify_operator(operator) <> ")"
    Special(special) -> "Special(" <> stringify_special(special) <> ")"
    Comment(comment) -> "Comment(" <> comment <> ")"
    Metadata(key, value) -> "Metadata(" <> key <> ":" <> value <> ")"
    MacroDefinition(key, value) ->
      "MacroDefinition(" <> key <> " -> " <> value <> ")"
    StringLiteral(string) -> "StringLiteral(" <> string <> ")"
    Keyword(keyword) -> "Keyword(" <> keyword.stringify(keyword) <> ")"
    Identifier(identifier) -> "Identifier(" <> identifier <> ")"
    Whitespace(lines) -> "Whitespace(" <> int.to_string(lines) <> ")"
  }
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
  ]
  |> list.map(fn(tuple) {
    let #(token, value) = tuple
    helper.exact(token, [], Special(value))
  })
}

/// https://www.sqlite.org/lang_expr.html
fn operators() -> List(Matcher(Token, a)) {
  [
    helper.exact("~", [], Operator(Tilda)),
    helper.exact("+", [], Operator(Plus)),
    helper.exact("-", ["-"], Operator(Minus)),
    helper.exact("||", [], Operator(LogicalOr)),
    helper.exact("->", [">"], Operator(ExtractText)),
    helper.exact("->>", [], Operator(ExtractParsed)),
    helper.exact("*", [], Operator(Multiply)),
    helper.exact("/", ["*"], Operator(Divide)),
    helper.exact("%", [], Operator(Modulo)),
    helper.exact("&", [], Operator(BinaryAnd)),
    helper.exact("|", ["|"], Operator(BinaryOr)),
    helper.exact("<<", [], Operator(ShiftLeft)),
    helper.exact(">>", [], Operator(ShiftRight)),
    helper.exact("<", ["<", ">", "="], Operator(LessThan)),
    helper.exact(">", [">", "="], Operator(GreaterThan)),
    helper.exact("<=", [], Operator(LessThanOrEqual)),
    helper.exact(">=", [], Operator(GreaterThanOrEqual)),
    helper.exact("=", ["="], Operator(Equals)),
    helper.exact("==", [], Operator(EqualsEquals)),
    helper.exact("<>", [], Operator(LessOrGreaterThan)),
    helper.exact("!=", [], Operator(NotEquals)),
  ]
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
