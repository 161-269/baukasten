import gleam/int
import gleam/io
import gleam/list
import gleeunit
import gleeunit/should
import helper
import lexer

pub fn main() {
  gleeunit.main()
}

pub fn hello_world_test() {
  let cases = helper.load_test_cases()
  //  list.map(cases, fn(tuple) {
  //    let #(path, input) = tuple
  //    let tokens = lexer.lex(path, input)
  //
  //    //io.debug(path)
  //    list.fold(tokens, 0, fn(index, token) {
  //      //io.println(int.to_string(index) <> ":")
  //      //io.debug(token.value)
  //      //io.println(token.lexeme)
  //      index + 1
  //    })
  //
  //    //should.be_true(False)
  //
  //    tokens
  //  })
}
