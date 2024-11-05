import gleam/dict
import gleam/io
import gleam/list
import gleeunit/should
import simplifile.{type FileError}

pub const sql_files_directory = "test/sql_files"

const input_directory = sql_files_directory <> "/input"

pub type Options {
  Options(generate: Bool)
}

pub type TestCase {
  TestCase(path: String, file_name: String, content: String)
}

pub type TestCaseError {
  TestCaseError(
    path: String,
    file_name: String,
    error: FileError,
    print: fn() -> Nil,
  )
}

pub fn load_test_cases() -> List(Result(TestCase, TestCaseError)) {
  let tests = simplifile.read_directory(input_directory)

  case tests {
    Error(error) -> {
      io.println_error("Error loading test cases from directory:")
      io.println_error(input_directory)
      io.println_error(simplifile.describe_error(error))
    }
    Ok(_) -> Nil
  }

  should.be_ok(tests)
  |> list.map(fn(file_name) {
    io.print(".")

    let path = input_directory <> "/" <> file_name
    let content = simplifile.read(path)

    case content {
      Ok(content) -> Ok(TestCase(path:, file_name:, content:))
      Error(error) ->
        Error(
          TestCaseError(path:, file_name:, error:, print: fn() {
            io.println_error("Error reading test case:")
            io.println_error(path)
            io.println_error(simplifile.describe_error(error))
          }),
        )
    }
  })
}

pub type CompareResult(a) =
  Result(CompareInput(a), CompareError(a))

pub type CompareInput(a) {
  CompareInput(value: a, file_name: String, content: String)
}

pub type CompareError(a) {
  ReadExistingTestError(
    path: String,
    file_name: String,
    error: simplifile.FileError,
    print: fn() -> Nil,
  )
  CouldNotGenerateTest(
    input: CompareInput(a),
    path: String,
    file_name: String,
    content: String,
    error: simplifile.FileError,
    print: fn() -> Nil,
  )
  ExistingTestNotHandled(
    path: String,
    file_name: String,
    content: String,
    print: fn() -> Nil,
  )
  CouldNotDeleteTest(
    path: String,
    file_name: String,
    content: String,
    error: simplifile.FileError,
    print: fn() -> Nil,
  )
  TestCaseNotFound(
    input: CompareInput(a),
    path: String,
    file_name: String,
    print: fn() -> Nil,
  )
  TestCaseNotMatched(
    input: CompareInput(a),
    path: String,
    file_name: String,
    existing_content: String,
    print: fn() -> Nil,
  )
}

pub fn compare(
  test_result: List(CompareInput(a)),
  directory_name: String,
  options: Options,
) -> List(CompareResult(a)) {
  let directory_path = sql_files_directory <> "/" <> directory_name

  case options.generate {
    True ->
      case simplifile.create_directory_all(directory_path) {
        Ok(_) -> Nil
        Error(error) -> {
          io.println_error("Error creating test results directory:")
          io.println_error(directory_path)
          io.println_error(simplifile.describe_error(error))
        }
      }
    False -> Nil
  }

  let existing = simplifile.read_directory(directory_path)

  case existing {
    Error(error) -> {
      io.println_error("Error loading test results from directory:")
      io.println_error(directory_path)
      io.println_error(simplifile.describe_error(error))
    }
    Ok(_) -> Nil
  }

  let existing =
    should.be_ok(existing)
    |> list.map(fn(file_name) {
      let path = directory_path <> "/" <> file_name
      let content = simplifile.read(path)

      case content {
        Ok(content) -> Ok(#(file_name, path, content))
        Error(error) ->
          Error(
            ReadExistingTestError(path:, file_name:, error:, print: fn() {
              io.println_error("Error reading test result:")
              io.println_error(path)
              io.println_error(simplifile.describe_error(error))
            }),
          )
      }
    })

  let result =
    list.filter_map(existing, fn(test_case) {
      case test_case {
        Ok(_) -> Error(Nil)
        Error(error) -> Ok(Error(error))
      }
    })

  let existing =
    list.fold(existing, dict.new(), fn(acc, test_case) {
      case test_case {
        Ok(test_case) ->
          dict.insert(acc, test_case.0, #(test_case.1, test_case.2))
        Error(_) -> acc
      }
    })

  let #(result, existing) =
    list.fold(test_result, #(result, existing), fn(acc, test_case) {
      let #(result, existing) = acc

      case dict.get(existing, test_case.file_name) {
        Error(_) -> {
          let path = directory_path <> "/" <> test_case.file_name

          let result = [
            generate(
              test_case,
              path,
              options,
              TestCaseNotFound(
                input: test_case,
                path:,
                file_name: test_case.file_name,
                print: fn() {
                  io.println_error(
                    "Could not find an expected test case result at:",
                  )
                  io.println_error(path)
                  io.println_error(
                    "Maybe you have forgotten to create it or your test failed.",
                  )
                  io.println_error("Expected the following content:")
                  io.println_error(test_case.content)
                },
              ),
            ),
            ..result
          ]

          #(result, existing)
        }
        Ok(value) -> {
          let existing = dict.delete(existing, test_case.file_name)
          let #(path, existing_content) = value

          let result = case existing_content == test_case.content {
            True -> [Ok(test_case), ..result]
            False -> [
              generate(
                test_case,
                path,
                options,
                TestCaseNotMatched(
                  input: test_case,
                  path:,
                  file_name: test_case.file_name,
                  existing_content:,
                  print: fn() {
                    io.println_error("Test case did not match:")
                    io.println_error(path)
                    io.println_error("Expected:")
                    io.println_error(test_case.content)
                    io.println_error("But got:")
                    io.println_error(existing_content)
                  },
                ),
              ),
              ..result
            ]
          }

          #(result, existing)
        }
      }
    })

  dict.fold(existing, result, fn(result, file_name, value) {
    let #(path, content) = value

    let test_case_error =
      Error(
        ExistingTestNotHandled(path:, file_name:, content:, print: fn() {
          io.println_error("Existing test case was not handled:")
          io.println_error(path)
          io.println_error(
            "Either your test failed or you have forgotten to delete the expected file.",
          )
          io.println_error("The content of the file is:")
          io.println_error(content)
        }),
      )
    case options.generate {
      False -> [test_case_error, ..result]
      True ->
        case simplifile.delete(path) {
          Ok(_) -> result
          Error(error) -> [
            Error(
              CouldNotDeleteTest(
                path:,
                file_name:,
                content:,
                error:,
                print: fn() {
                  io.println_error("Could not delete test case result at:")
                  io.println_error(path)
                  io.println_error("Error:")
                  io.println_error(simplifile.describe_error(error))
                },
              ),
            ),
          ]
        }
    }
  })
}

fn generate(
  test_case: CompareInput(a),
  path: String,
  options: Options,
  error: CompareError(a),
) -> Result(CompareInput(a), CompareError(a)) {
  case options.generate {
    False -> Error(error)
    True ->
      case simplifile.write(path, test_case.content) {
        Error(error) ->
          Error(
            CouldNotGenerateTest(
              input: test_case,
              path:,
              file_name: test_case.file_name,
              content: test_case.content,
              error:,
              print: fn() {
                io.println_error("Could not generate test case result at:")
                io.println_error(path)
                io.println_error("Error:")
                io.println_error(simplifile.describe_error(error))
              },
            ),
          )

        Ok(_) -> Ok(test_case)
      }
  }
}

pub fn oks(result: List(CompareResult(a))) -> List(CompareInput(a)) {
  list.filter_map(result, fn(result) {
    case result {
      Ok(result) -> Ok(result)
      Error(_) -> Error(Nil)
    }
  })
}

pub fn errors(result: List(CompareResult(a))) -> List(CompareError(a)) {
  list.filter_map(result, fn(result) {
    case result {
      Error(result) -> Ok(result)
      Ok(_) -> Error(Nil)
    }
  })
}
