import chomp/lexer as chomp_lexer
import gleam/int
import gleam/io
import gleeunit/should
import immutype_lite/parser/lexer

pub fn lex(path: String, input: String) -> List(chomp_lexer.Token(lexer.Token)) {
  let lexer = lexer.lexer()

  let result = chomp_lexer.run(input, lexer)

  case result {
    Error(error) -> {
      io.println("")
      io.println("Error lexing file:")
      io.println(
        path
        <> ":"
        <> int.to_string(error.row)
        <> ":"
        <> int.to_string(error.col),
      )
      io.println("")
      io.println("Remaining input:")
      io.println("")
      io.println(error.lexeme)
      io.println("")
    }
    Ok(_) -> Nil
  }

  should.be_ok(result)
}
