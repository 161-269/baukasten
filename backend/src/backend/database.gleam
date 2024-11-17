import feather
import feather/migrate
import gleam/erlang
import gleam/erlang/process.{type Subject}
import gleam/function
import gleam/otp/actor
import gleam/result
import puddle
import sqlight.{type Connection}

pub opaque type Db(x) {
  Db(pool: Subject(puddle.ManagerMessage(Connection, x)))
}

pub type Error {
  PrivateDirectoryNotFound
  MigrationError(migrate.MigrationError)
  SqlightError(sqlight.Error)
  PoolError(actor.StartError)
  CouldNotGetPoolConnection
}

pub fn connect(file: String, connections: Int) -> Result(Db(x), Error) {
  use priv_dir <- result.try(
    erlang.priv_directory("backend")
    |> result.map_error(fn(_) { PrivateDirectoryNotFound }),
  )

  use migrations <- result.try(
    migrate.get_migrations(priv_dir <> "/migrations")
    |> result.map_error(MigrationError),
  )

  let config = feather.Config(..feather.default_config(), file: file)

  use connection <- result.try(
    feather.connect(config)
    |> result.map_error(SqlightError),
  )

  use _ <- result.try(
    migrate.migrate(migrations, on: connection)
    |> result.map_error(MigrationError),
  )

  use _ <- result.try(
    feather.optimize(connection)
    |> result.map_error(SqlightError),
  )

  use _ <- result.then(
    feather.disconnect(connection) |> result.map_error(SqlightError),
  )

  use pool <- result.then(
    puddle.start(connections, fn() {
      feather.connect(config) |> result.replace_error(Nil)
    })
    |> result.map_error(PoolError),
  )

  Ok(Db(pool: pool))
}

pub fn connection(
  db: Db(Result(a, b)),
  wait_timeout: Int,
  pool_connection_error: fn() -> b,
  context: fn(Connection) -> Result(a, b),
) -> Result(a, b) {
  let result =
    puddle.apply(
      db.pool,
      fn(connection) { context(connection) },
      wait_timeout,
      function.identity,
    )

  case result {
    Ok(result) -> result
    Error(Nil) -> Error(pool_connection_error())
  }
}

pub fn transaction(
  db: Db(Result(a, b)),
  wait_timeout: Int,
  map_error: fn(Error) -> b,
  context: fn(Connection) -> Result(a, b),
) -> Result(a, b) {
  use connection <- connection(db, wait_timeout, fn() {
    map_error(CouldNotGetPoolConnection)
  })

  transaction_block(connection, map_error, context)
}

pub fn disconnect(db: Db(x)) {
  use connection <- puddle.shutdown(db.pool)

  let _ = feather.disconnect(connection)

  Nil
}

fn transaction_block(
  connection: Connection,
  map_error: fn(Error) -> b,
  context: fn(Connection) -> Result(a, b),
) -> Result(a, b) {
  let map = fn(map: fn(x) -> Error) -> fn(x) -> b {
    fn(error: x) {
      map(error)
      |> map_error
    }
  }

  use _ <- result.then(
    sqlight.exec("BEGIN TRANSACTION;", connection)
    |> result.map_error(map(SqlightError)),
  )

  let result = context(connection)

  case result {
    Ok(_) -> {
      use _ <- result.then(
        sqlight.exec("COMMIT TRANSACTION;", connection)
        |> result.map_error(map(SqlightError)),
      )

      result
    }
    Error(_) -> {
      let _ =
        sqlight.exec("ROLLBACK TRANSACTION;", connection)
        |> result.map_error(map(SqlightError))

      result
    }
  }
}
