import backend/database.{type Db}
import gleam/dict
import gleam/erlang/process.{type Subject}
import gleam/io
import gleam/list.{Continue, Stop}
import gleam/otp/actor.{type Next}
import gleam/result
import gleam/string

pub opaque type PageRequest {
  PageRequest(worker: Subject(Msg))
}

pub fn new(db: Db, interval_millisecond: Int) -> Result(PageRequest, Nil) {
  use worker <- result.try(
    actor.start(State(db:, logs: [], interval_millisecond:), update)
    |> result.map_error(fn(_) { Nil }),
  )

  process.send_after(worker, interval_millisecond, Write(worker))

  Ok(PageRequest(worker:))
}

type Request {
  Request(time: Int, session: BitArray, path: String)
}

type Msg {
  Write(worker: Subject(Msg))
  Log(Request)
  Close
}

type State {
  State(db: Db, logs: List(Request), interval_millisecond: Int)
}

fn update(msg: Msg, state: State) -> Next(Msg, State) {
  case msg {
    Close -> actor.Stop(process.Normal)
    Log(request) ->
      State(..state, logs: [request, ..state.logs]) |> actor.continue
    Write(worker) -> {
      let result = case state.logs {
        [] -> state
        logs -> {
          let sessions = dict.new()
          let paths = dict.new()

          let logs = case
            database.connection(
              state.db,
              250,
              fn(error) { error },
              fn(connection) {
                let #(_, _, result) =
                  list.fold_until(
                    logs,
                    #(sessions, paths, Ok(Nil)),
                    fn(acc, log) {
                      let #(sessions, paths, _) = acc

                      case
                        {
                          use #(sessions, visitor_id) <- result.try(case
                            dict.get(sessions, log.session)
                          {
                            Ok(id) -> Ok(#(sessions, id))
                            Error(Nil) ->
                              connection.stmts.visitor_session.get_by_session_key_or_insert_new(
                                log.session,
                                log.time,
                              )
                              |> result.map(fn(visitor_session) {
                                #(
                                  dict.insert(
                                    sessions,
                                    log.session,
                                    visitor_session.visitor_id,
                                  ),
                                  visitor_session.visitor_id,
                                )
                              })
                          })

                          let path = string.lowercase(log.path)
                          use #(paths, path_id) <- result.try(case
                            dict.get(paths, path)
                          {
                            Ok(id) -> Ok(#(paths, id))
                            Error(Nil) ->
                              connection.stmts.page_request.get_path_id(
                                log.path,
                              )
                              |> result.map(fn(id) {
                                #(dict.insert(paths, path, id), id)
                              })
                          })

                          connection.stmts.page_request.insert_new_with_path_id(
                            visitor_id,
                            path_id,
                            log.time,
                          )
                          |> result.map(fn(_) { #(sessions, paths) })
                        }
                      {
                        Ok(#(sessions, paths)) ->
                          Continue(#(sessions, paths, Ok(Nil)))
                        Error(error) ->
                          Stop(#(
                            sessions,
                            paths,
                            Error(database.SqlightError(error)),
                          ))
                      }
                    },
                  )

                result
              },
            )
          {
            Ok(_) -> []
            Error(error) -> {
              io.debug(error)
              logs
            }
          }
          State(..state, logs: logs)
        }
      }

      process.send_after(worker, state.interval_millisecond, Write(worker))
      result |> actor.continue
    }
  }
}

pub fn log(
  page_request: PageRequest,
  time: Int,
  session: BitArray,
  path: String,
) {
  process.send(page_request.worker, Log(Request(time, session, path)))
}
