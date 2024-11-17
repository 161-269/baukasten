//// https://www.sqlite.org/lang.html

import chomp/lexer.{type Lexer, type Matcher}
import gleam/float
import gleam/int
import gleam/list.{Continue, Stop}
import gleam/regex
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
  Numeric(Numeric)
  StringLiteral(String)
  Keyword(String, Keyword)
  Identifier(String)
  Whitespace(lines: Int)
}

pub type Numeric {
  Integer(Int)
  Floating(Float)
}

pub fn stringify_token(token: Token) -> String {
  case token {
    Operator(operator) -> "Operator(" <> stringify_operator(operator) <> ")"
    Special(special) -> "Special(" <> stringify_special(special) <> ")"
    Comment(comment) -> "Comment(" <> comment <> ")"
    Metadata(key, value) -> "Metadata(" <> key <> ":" <> value <> ")"
    MacroDefinition(key, value) ->
      "MacroDefinition(" <> key <> " -> " <> value <> ")"
    Numeric(numeric) ->
      "Numeric("
      <> case numeric {
        Integer(value) -> int.to_string(value)
        Floating(value) -> float.to_string(value)
      }
      <> ")"
    StringLiteral(string) -> "StringLiteral(" <> string <> ")"
    Keyword(_, keyword) -> "Keyword(" <> keyword.stringify(keyword) <> ")"
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
    |> string.drop_start(7)
    |> string.trim

  case string.split_once(input, " ") {
    Ok(#(key, value)) ->
      MacroDefinition(string.trim_end(key), string.trim_start(value))
    Error(_) -> MacroDefinition("", input)
  }
}

fn new_macro_definition(input: String) -> Token {
  let input =
    input
    |> string.drop_start(8)
    |> string.trim

  case string.split_once(input, " ") {
    Ok(#(key, value)) ->
      MacroDefinition(string.trim_end(key), string.trim_start(value))
    Error(_) -> MacroDefinition("", input)
  }
}

fn comments() -> List(Matcher(Token, a)) {
  [
    helper.regex_matcher("^---\\s*\\w+\\s*:\\s*\\w+\\s*", "\n", new_metadata),
    helper.regex_matcher("^--([^-].*)?", "\n", fn(input) {
      Comment(string.drop_start(input, 2))
    }),
    helper.regex_matcher("^\\/\\*[\\s\\S]*?\\*\\/", "", fn(input) {
      Comment(input |> string.drop_start(2) |> string.drop_end(2))
    }),
    helper.regex_matcher("^#(?!define\\s).*", "\n", fn(input) {
      Comment(input |> string.drop_start(1))
    }),
    helper.regex_matcher(
      "^#define\\s+\\w+\\s* \\s*\\w+\\s*",
      "\n",
      new_macro_definition,
    ),
  ]
}

fn identifiers() -> List(Matcher(Token, a)) {
  let assert Ok(is_digit) = regex.from_string("[\\d]")
  let assert Ok(identifier_first_char_regex) = regex.from_string("[\\w_]")
  let assert Ok(identifier_trailing_char_regex) = regex.from_string("[\\w_\\d]")
  let between = fn(value: String, utf_codepoints: List(#(Int, Int))) -> Bool {
    string.to_utf_codepoints(value)
    |> list.map(string.utf_codepoint_to_int)
    |> list.all(fn(codepoint) {
      list.any(utf_codepoints, fn(range) {
        codepoint >= range.0 && codepoint <= range.1
      })
    })
  }

  // https://www.unicode.org/Public/emoji/
  let is_emoji = fn(value: String) -> Bool {
    between(value, [
      // '©' - '©'
      #(0xa9, 0xa9),
      // '®' - '®'
      #(0xae, 0xae),
      // '‼' - '‼'
      #(0x203c, 0x203c),
      // '⁉' - '⁉'
      #(0x2049, 0x2049),
      // '⃣' - '⃣'
      #(0x20e3, 0x20e3),
      // '™' - '™'
      #(0x2122, 0x2122),
      // 'ℹ' - 'ℹ'
      #(0x2139, 0x2139),
      // '↔' - '↙'
      #(0x2194, 0x2199),
      // '↩' - '↪'
      #(0x21a9, 0x21aa),
      // '⌚' - '⌛'
      #(0x231a, 0x231b),
      // '⌨' - '⌨'
      #(0x2328, 0x2328),
      // '⎈' - '⎈'
      #(0x2388, 0x2388),
      // '⏏' - '⏏'
      #(0x23cf, 0x23cf),
      // '⏩' - '⏳'
      #(0x23e9, 0x23f3),
      // '⏸' - '⏺'
      #(0x23f8, 0x23fa),
      // 'Ⓜ' - 'Ⓜ'
      #(0x24c2, 0x24c2),
      // '▪' - '▫'
      #(0x25aa, 0x25ab),
      // '▶' - '▶'
      #(0x25b6, 0x25b6),
      // '◀' - '◀'
      #(0x25c0, 0x25c0),
      // '◻' - '◾'
      #(0x25fb, 0x25fe),
      // '☀' - '★'
      #(0x2600, 0x2605),
      // '☇' - '☒'
      #(0x2607, 0x2612),
      // '☔' - '⚅'
      #(0x2614, 0x2685),
      // '⚐' - '✅'
      #(0x2690, 0x2705),
      // '✈' - '✒'
      #(0x2708, 0x2712),
      // '✔' - '✔'
      #(0x2714, 0x2714),
      // '✖' - '✖'
      #(0x2716, 0x2716),
      // '✝' - '✝'
      #(0x271d, 0x271d),
      // '✡' - '✡'
      #(0x2721, 0x2721),
      // '✨' - '✨'
      #(0x2728, 0x2728),
      // '✳' - '✴'
      #(0x2733, 0x2734),
      // '❄' - '❄'
      #(0x2744, 0x2744),
      // '❇' - '❇'
      #(0x2747, 0x2747),
      // '❌' - '❌'
      #(0x274c, 0x274c),
      // '❎' - '❎'
      #(0x274e, 0x274e),
      // '❓' - '❕'
      #(0x2753, 0x2755),
      // '❗' - '❗'
      #(0x2757, 0x2757),
      // '❣' - '❧'
      #(0x2763, 0x2767),
      // '➕' - '➗'
      #(0x2795, 0x2797),
      // '➡' - '➡'
      #(0x27a1, 0x27a1),
      // '➰' - '➰'
      #(0x27b0, 0x27b0),
      // '➿' - '➿'
      #(0x27bf, 0x27bf),
      // '⤴' - '⤵'
      #(0x2934, 0x2935),
      // '⬅' - '⬇'
      #(0x2b05, 0x2b07),
      // '⬛' - '⬜'
      #(0x2b1b, 0x2b1c),
      // '⭐' - '⭐'
      #(0x2b50, 0x2b50),
      // '⭕' - '⭕'
      #(0x2b55, 0x2b55),
      // '〰' - '〰'
      #(0x3030, 0x3030),
      // '〽' - '〽'
      #(0x303d, 0x303d),
      // '㊗' - '㊗'
      #(0x3297, 0x3297),
      // '㊙' - '㊙'
      #(0x3299, 0x3299),
      // '️' - '️'
      #(0xfe0f, 0xfe0f),
      // '🀀' - '🃿'
      #(0x1f000, 0x1f0ff),
      // '🄍' - '🄏'
      #(0x1f10d, 0x1f10f),
      // '🄯' - '🄯'
      #(0x1f12f, 0x1f12f),
      // '🅬' - '🅱'
      #(0x1f16c, 0x1f171),
      // '🅾' - '🅿'
      #(0x1f17e, 0x1f17f),
      // '🆎' - '🆎'
      #(0x1f18e, 0x1f18e),
      // '🆑' - '🆚'
      #(0x1f191, 0x1f19a),
      // '🆭' - '🇿'
      #(0x1f1ad, 0x1f1ff),
      // '🈁' - '🈏'
      #(0x1f201, 0x1f20f),
      // '🈚' - '🈚'
      #(0x1f21a, 0x1f21a),
      // '🈯' - '🈯'
      #(0x1f22f, 0x1f22f),
      // '🈲' - '🈺'
      #(0x1f232, 0x1f23a),
      // '🈼' - '🈿'
      #(0x1f23c, 0x1f23f),
      // '🉉' - '🔽'
      #(0x1f249, 0x1f53d),
      // '🕆' - '🙏'
      #(0x1f546, 0x1f64f),
      // '🚀' - '🛿'
      #(0x1f680, 0x1f6ff),
      // '🝴' - '🝿'
      #(0x1f774, 0x1f77f),
      // '🟕' - '🟿'
      #(0x1f7d5, 0x1f7ff),
      // '🠌' - '🠏'
      #(0x1f80c, 0x1f80f),
      // '🡈' - '🡏'
      #(0x1f848, 0x1f84f),
      // '🡚' - '🡟'
      #(0x1f85a, 0x1f85f),
      // '🢈' - '🢏'
      #(0x1f888, 0x1f88f),
      // '🢮' - '🣿'
      #(0x1f8ae, 0x1f8ff),
      // '🤌' - '🤺'
      #(0x1f90c, 0x1f93a),
      // '🤼' - '🥅'
      #(0x1f93c, 0x1f945),
      // '🥇' - '🿽'
      #(0x1f947, 0x1fffd),
      // '󠀠' - '󠁿'
      #(0xe0020, 0xe007f),
    ])
  }

  [
    helper.complex_matcher(
      fn(input) {
        input != ""
        && string.to_graphemes(input)
        |> list.fold_until(0, fn(index, grapheme) {
          let ok = case index {
            0 ->
              !regex.check(is_digit, grapheme)
              && {
                regex.check(identifier_first_char_regex, grapheme)
                || is_emoji(grapheme)
              }
            _ ->
              regex.check(identifier_trailing_char_regex, grapheme)
              || is_emoji(grapheme)
          }

          case ok {
            True -> Continue(index + 1)
            False -> Stop(-1)
          }
        })
        != -1
      },
      helper.breaker_regex,
      Identifier(_),
    ),
    helper.regex_matcher(
      "^\"(?:\"\"|[^\"])*(?!\"\")\"",
      helper.breaker_regex,
      fn(input) {
        Identifier(input |> string.drop_start(1) |> string.drop_end(1))
      },
    ),
    helper.regex_matcher("^\\[[^\\]]*\\]", helper.breaker_regex, fn(input) {
      Identifier(input |> string.drop_start(1) |> string.drop_end(1))
    }),
    helper.regex_matcher("^`[^`]*`", helper.breaker_regex, fn(input) {
      Identifier(input |> string.drop_start(1) |> string.drop_end(1))
    }),
  ]
}

fn string_literals() -> List(Matcher(Token, a)) {
  [
    helper.regex_matcher(
      "^'(?:''|[^'])*(?!'')'",
      helper.breaker_regex,
      fn(input) {
        StringLiteral(input |> string.drop_start(1) |> string.drop_end(1))
      },
    ),
  ]
}

fn number_literals() -> List(Matcher(Token, a)) {
  [
    lexer.number(fn(value) { Numeric(Integer(value)) }, fn(value) {
      Numeric(Floating(value))
    }),
    lexer.number_with_separator(
      "_",
      fn(value) { Numeric(Integer(value)) },
      fn(value) { Numeric(Floating(value)) },
    ),
  ]
}
