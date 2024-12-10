import gleam/option.{type Option}

pub type Executable

@external(erlang, "backend_ffi", "spawn_executable")
fn spawn_executable(
  working_directory: String,
  executable_path: String,
  args: List(String),
  data_callback: fn(String) -> Nil,
  exit_callback: fn(Result(Int, String)) -> Nil,
  timeout: Option(Int),
) -> Executable

@external(erlang, "backend_ffi", "kill_executable")
fn kill_executable(executable: Executable) -> Nil

@external(erlang, "backend_ffi", "send_to_executable")
fn send_to_executable(executable: Executable, data: String) -> Nil

@external(erlang, "backend_ffi", "set_timeout")
fn set_timeout(executable: Executable, timeout: Option(Int)) -> Nil

pub fn spawn(
  working_directory: String,
  executable_path: String,
  args: List(String),
  data_callback: fn(String) -> Nil,
  exit_callback: fn(Result(Int, String)) -> Nil,
  timeout_milliseconds: Option(Int),
) -> Executable {
  spawn_executable(
    working_directory,
    executable_path,
    args,
    data_callback,
    exit_callback,
    timeout_milliseconds,
  )
}

pub fn send(executable: Executable, data: String) -> Nil {
  send_to_executable(executable, data)
}

pub fn kill(executable: Executable) -> Nil {
  kill_executable(executable)
}

pub fn timeout(executable: Executable, timeout_milliseconds: Option(Int)) -> Nil {
  set_timeout(executable, timeout_milliseconds)
}
