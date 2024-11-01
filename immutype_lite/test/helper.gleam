import gleam/io
import gleam/list
import gleeunit/should
import simplifile

pub fn load_test_cases() -> List(#(String, String)) {
  let tests = simplifile.read_directory("test/sql_files/input")

  case tests {
    Error(error) -> {
      io.println("Error loading test cases from directory:")
      io.println(simplifile.describe_error(error))
    }
    Ok(_) -> Nil
  }

  should.be_ok(tests)
  |> list.map(fn(name) { "test/sql_files/input/" <> name })
  |> list.map(fn(path) {
    let content = simplifile.read(path)

    case content {
      Error(error) -> {
        io.println("Error reading test case:")
        io.println(path)
        io.println(simplifile.describe_error(error))
      }
      Ok(_) -> Nil
    }

    #(path, should.be_ok(content))
  })
}
