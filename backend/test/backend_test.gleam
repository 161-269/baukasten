import backend/database/configuration
import backend/database/user
import gleam/list
import gleam/option.{None}
import gleeunit
import gleeunit/should
import simplifile
import sqlight.{type Connection}

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  1
  |> should.equal(1)
}

fn use_db(callback: fn(Connection) -> a) -> a {
  let schema =
    simplifile.read("./priv/migrations/1730062059_initial_schema_migration.sql")
    |> should.be_ok

  let db =
    sqlight.open("file::memory:")
    |> should.be_ok

  sqlight.exec(schema, db)
  |> should.be_ok

  callback(db)
}

pub fn database_configuration_test() {
  use db <- use_db

  list.map(["test", "a.test", "b.test", "a.test.a"], fn(key) {
    configuration.get(db, key)
    |> should.be_ok
    |> should.be_none

    configuration.set(db, key, "1", 1) |> should.be_ok
    configuration.get(db, key)
    |> should.be_ok
    |> option.map(fn(c) {
      should.equal(c.key, key)
      should.equal(c.value, "1")
      should.equal(c.created_at, 1)
    })
    |> should.be_some

    configuration.set(db, key, "3", 3) |> should.be_ok
    configuration.get(db, key)
    |> should.be_ok
    |> option.map(fn(c) {
      should.equal(c.key, key)
      should.equal(c.value, "3")
      should.equal(c.created_at, 3)
    })
    |> should.be_some

    configuration.set(db, key, "2", 2) |> should.be_ok
    configuration.get(db, key)
    |> should.be_ok
    |> option.map(fn(c) {
      should.equal(c.key, key)
      should.equal(c.value, "3")
      should.equal(c.created_at, 3)
    })
    |> should.be_some

    configuration.set(db, key, "5", 5) |> should.be_ok
    configuration.get(db, key)
    |> should.be_ok
    |> option.map(fn(c) {
      should.equal(c.key, key)
      should.equal(c.value, "5")
      should.equal(c.created_at, 5)
    })
    |> should.be_some

    configuration.set(db, key, "0", 0) |> should.be_ok
    configuration.get(db, key)
    |> should.be_ok
    |> option.map(fn(c) {
      should.equal(c.key, key)
      should.equal(c.value, "5")
      should.equal(c.created_at, 5)
    })
    |> should.be_some

    configuration.set(db, key, "0", 0) |> should.be_error
  })
}

pub fn database_user_test() {
  use db <- use_db

  user.count(db) |> should.be_ok |> should.equal(0)
  user.search(db, "alice") |> should.be_ok |> should.be_none
  user.search(db, "bob") |> should.be_ok |> should.be_none

  user.search(db, "alice@example.com") |> should.be_ok |> should.be_none
  user.search(db, "bob@example.com") |> should.be_ok |> should.be_none

  user.insert_new(db, "alice", "alice@example.com", "123456789012345")
  |> should.be_error
  user.count(db) |> should.be_ok |> should.equal(0)

  let alice =
    user.insert_new(db, "alice", "alice@example.com", "1234567890123456")
    |> should.be_ok
  user.count(db) |> should.be_ok |> should.equal(1)

  user.search(db, "alice")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)
  user.search(db, "alIcE")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)
  user.search(db, "alice@example.com")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)
  user.search(db, "alice@examplE.com")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)

  let bob =
    user.insert_new(
      db,
      "bob",
      "bob@example.com",
      "Passwort with more than 16 chars.",
    )
    |> should.be_ok
  user.count(db) |> should.be_ok |> should.equal(2)

  bob |> should.not_equal(alice)
  bob.id |> should.not_equal(alice.id)

  user.search(db, "bOb")
  |> should.be_ok
  |> should.be_some
  |> should.equal(bob)

  user.search(db, "alice")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)

  user.insert_new(db, "alice", "fake@example.com", "1234567890123456")
  |> should.be_error
  user.insert_new(db, "fake", "alice@example.com", "1234567890123456")
  |> should.be_error
  user.insert_new(db, "charlie", "charlie(at)example.com", "1234567890123456")
  |> should.be_error
  user.insert_new(db, "cha@rlie", "charlie@example.com", "1234567890123456")
  |> should.be_error

  user.sarch_and_verify(db, "alice", "1234567890123456")
  |> should.be_ok
  |> should.equal(alice)

  user.sarch_and_verify(db, "bob", "1234567890123456")
  |> should.be_error

  let abby =
    user.update(db, user.User(..alice, username: "abby"), None)
    |> should.be_ok

  abby |> should.not_equal(alice)

  user.search(db, "abby")
  |> should.be_ok
  |> should.be_some
  |> should.equal(abby)

  user.search(db, "alice")
  |> should.be_ok
  |> should.be_none

  user.count(db) |> should.be_ok |> should.equal(2)
}
