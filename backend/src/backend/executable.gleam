pub type Executable

@external(erlang, "backend_ffi", "spawn_executable")
fn spawn_executable(
  working_directory: String,
  executable_path: String,
  args: List(String),
  data_callback: fn(String) -> Nil,
  exit_callback: fn(Result(Int, String)) -> Nil,
) -> Executable

@external(erlang, "backend_ffi", "kill_executable")
fn kill_executable(executable: Executable) -> Nil

@external(erlang, "backend_ffi", "send_to_executable")
fn send_to_executable(executable: Executable, data: String) -> Nil

pub fn spawn(
  working_directory: String,
  executable_path: String,
  args: List(String),
  data_callback: fn(String) -> Nil,
  exit_callback: fn(Result(Int, String)) -> Nil,
) -> Executable {
  spawn_executable(
    working_directory,
    executable_path,
    args,
    data_callback,
    exit_callback,
  )
}

pub fn send(executable: Executable, data: String) -> Nil {
  send_to_executable(executable, data)
}

pub fn kill(executable: Executable) -> Nil {
  kill_executable(executable)
}
