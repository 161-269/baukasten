import argv
import clip
import clip/flag
import gleam/io
import gleam/list
import gleeunit/should
import helper.{type Options, Options}
import lexer

fn command() {
  clip.command({
    use generate <- clip.parameter

    Options(generate:)
  })
  |> clip.flag(
    flag.new("generate") |> flag.help("Generates files for snapshot testing"),
  )
}

pub fn main() {
  // Has a default timeout of 5 seconds
  // this is not enough for the tests
  // gleeunit.main()

  hello_world_test()
}

pub fn hello_world_test() {
  let options = command() |> clip.run(argv.load().arguments)
  let options = case options {
    Ok(options) -> options
    Error(error) -> {
      io.println_error("Encountered an error parsing command line arguments:")
      io.println_error(error)
      should.be_ok(options)
    }
  }

  let cases = helper.load_test_cases()
  let case_errors =
    list.fold(cases, False, fn(_, test_case) {
      case test_case {
        Error(error) -> {
          io.println_error("Encountered an error loading test cases:")
          error.print()
          True
        }
        Ok(_) -> False
      }
    })
  let cases =
    list.filter_map(cases, fn(test_case) {
      case test_case {
        Ok(test_case) -> Ok(test_case)
        Error(_) -> Error(Nil)
      }
    })

  let lexer = lexer.test_lexer(cases, options)
  let lexer_errors =
    helper.errors(lexer)
    |> list.fold(False, fn(_, error) {
      io.println_error("Encountered an error lexing test cases:")
      case error {
        helper.ExistingTestNotHandled(_, _, _, print)
        | helper.CouldNotGenerateTest(_, _, _, _, _, print)
        | helper.ReadExistingTestError(_, _, _, print)
        | helper.TestCaseNotFound(_, _, _, print)
        | helper.TestCaseNotMatched(_, _, _, _, print)
        | helper.CouldNotDeleteTest(_, _, _, _, print) -> print()
      }
      True
    })
  let _lexer = lexer.oks(lexer)

  should.be_false(case_errors)
  should.be_false(lexer_errors)
}
