import chomp/lexer.{type Error as ChompError, type Token as ChompToken} as chomp_lexer
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import gleam/string_tree
import helper.{
  type CompareInput, type CompareResult, type Options, type TestCase,
  CompareInput,
}
import immutype_lite/parser/lexer.{type Token}

pub type LexResult {
  LexResult(test_case: TestCase, tokens: List(ChompToken(Token)))
}

pub type LexError {
  ChompError(test_case: TestCase, error: ChompError, print: fn() -> Nil)
}

fn lex(
  lexer: chomp_lexer.Lexer(Token, Nil),
  test_case: TestCase,
) -> Result(LexResult, LexError) {
  let result = chomp_lexer.run(test_case.content, lexer)

  case result {
    Ok(tokens) -> Ok(LexResult(test_case:, tokens:))

    Error(error) ->
      Error(
        ChompError(test_case:, error:, print: fn() {
          io.println_error("Error lexing file:")
          io.println_error(
            test_case.path
            <> ":"
            <> int.to_string(error.row)
            <> ":"
            <> int.to_string(error.col),
          )
          io.println_error("Remaining input:")
          io.println_error(error.lexeme)
        }),
      )
  }
}

fn stringify_lex_result(lex_result: LexResult) -> String {
  string_tree.new()
  |> string_tree.append("Lexer result:\n\n")
  |> list.fold(
    lex_result.tokens,
    _,
    fn(acc, token) {
      acc
      |> string_tree.append(lexer.stringify_token(token.value))
      |> string_tree.append(" | ")
      |> string_tree.append(token.lexeme)
      |> string_tree.append("\n")
    },
  )
  |> string_tree.to_string
}

fn stringify_lex_error(lex_error: LexError) -> String {
  string_tree.new()
  |> string_tree.append("Lexer error:\n")
  |> string_tree.append(lex_error.test_case.path)
  |> string_tree.append(":")
  |> string_tree.append(int.to_string(lex_error.error.row))
  |> string_tree.append(":")
  |> string_tree.append(int.to_string(lex_error.error.col))
  |> string_tree.append("\n\n")
  |> string_tree.append(
    lex_error.test_case.content
    |> string.drop_end(string.length(lex_error.error.lexeme)),
  )
  |> string_tree.append("\n\nLexer error begins here:\nv\n")
  |> string_tree.append(lex_error.error.lexeme)
  |> string_tree.to_string
}

pub fn test_lexer(
  test_cases: List(TestCase),
  options: Options,
) -> List(CompareResult(Result(LexResult, LexError))) {
  let lexer = lexer.lexer()
  let result = list.map(test_cases, lex(lexer, _))

  list.map(result, fn(test_case) {
    io.print(".")

    let #(content, file_name) = case test_case {
      Error(error) -> #(stringify_lex_error(error), error.test_case.file_name)
      Ok(test_case) -> #(
        stringify_lex_result(test_case),
        test_case.test_case.file_name,
      )
    }
    CompareInput(value: test_case, file_name:, content:)
  })
  |> helper.compare("lexer", options)
}

pub fn oks(
  result: List(CompareResult(Result(LexResult, LexError))),
) -> List(LexResult) {
  helper.oks(result)
  |> list.filter_map(fn(result) {
    case result.value {
      Ok(result) -> Ok(result)
      Error(_) -> Error(Nil)
    }
  })
}

pub fn errors(
  result: List(CompareResult(Result(LexResult, LexError))),
) -> List(LexError) {
  helper.oks(result)
  |> list.filter_map(fn(result) {
    case result.value {
      Ok(_) -> Error(Nil)
      Error(result) -> Ok(result)
    }
  })
}
