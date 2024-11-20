import backend/database.{type Db}
import backend/database/page_request
import backend/database/visitor_session
import gleam/dict
import gleam/erlang/process.{type Subject}
import gleam/io
import gleam/list.{Continue, Stop}
import gleam/option.{None}
import gleam/otp/actor.{type Next}
import gleam/result
import gleam/string

pub opaque type PageRequest {
  PageRequest(worker: Subject(Msg))
}

pub fn new(db: Db, interval_millisecond: Int) -> Result(PageRequest, Nil) {
  use worker <- result.try(
    actor.start(State(db:, logs: []), update) |> result.map_error(fn(_) { Nil }),
  )

  use _ <- result.try(
    database.apply_interval(interval_millisecond, fn() {
      process.send(worker, Write)
    }),
  )

  Ok(PageRequest(worker:))
}

type Request {
  Request(time: Int, session: BitArray, path: String)
}

type Msg {
  Write
  Log(Request)
}

type State {
  State(db: Db, logs: List(Request))
}

fn update(msg: Msg, state: State) -> Next(Msg, State) {
  let state = case msg {
    Log(request) -> State(..state, logs: [request, ..state.logs])
    Write ->
      case state.logs {
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
                              visitor_session.get_by_session_key_or_insert_new(
                                connection,
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
                              page_request.get_path_id(connection, log.path)
                              |> result.map(fn(id) {
                                #(dict.insert(paths, path, id), id)
                              })
                          })

                          page_request.insert_new_with_path_id(
                            connection,
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
  }

  actor.Continue(state, None)
}

pub fn log(
  page_request: PageRequest,
  time: Int,
  session: BitArray,
  path: String,
) {
  process.send(page_request.worker, Log(Request(time, session, path)))
}
