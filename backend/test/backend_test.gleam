import backend/database.{type Connection}
import backend/database/user
import gleam/list
import gleam/option.{None}
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

fn use_db(callback: fn(Connection) -> a) -> Nil {
  let db =
    database.connect("file::memory:", 1, 60_000)
    |> should.be_ok

  database.connection(db, 200, fn(e) { e }, fn(connection) {
    Ok(callback(connection))
  })
  |> should.be_ok

  database.disconnect(db, 2000)
}

pub fn database_configuration_test() {
  use db <- use_db

  list.map(["test", "a.test", "b.test", "a.test.a"], fn(key) {
    db.stmts.config.get(key)
    |> should.be_ok
    |> should.be_none

    db.stmts.config.set(key, "1", 1) |> should.be_ok
    db.stmts.config.get(key)
    |> should.be_ok
    |> option.map(fn(c) {
      should.equal(c.key, key)
      should.equal(c.value, "1")
      should.equal(c.created_at, 1)
    })
    |> should.be_some

    db.stmts.config.set(key, "3", 3) |> should.be_ok
    db.stmts.config.get(key)
    |> should.be_ok
    |> option.map(fn(c) {
      should.equal(c.key, key)
      should.equal(c.value, "3")
      should.equal(c.created_at, 3)
    })
    |> should.be_some

    db.stmts.config.set(key, "2", 2) |> should.be_ok
    db.stmts.config.get(key)
    |> should.be_ok
    |> option.map(fn(c) {
      should.equal(c.key, key)
      should.equal(c.value, "3")
      should.equal(c.created_at, 3)
    })
    |> should.be_some

    db.stmts.config.set(key, "5", 5) |> should.be_ok
    db.stmts.config.get(key)
    |> should.be_ok
    |> option.map(fn(c) {
      should.equal(c.key, key)
      should.equal(c.value, "5")
      should.equal(c.created_at, 5)
    })
    |> should.be_some

    db.stmts.config.set(key, "0", 0) |> should.be_ok
    db.stmts.config.get(key)
    |> should.be_ok
    |> option.map(fn(c) {
      should.equal(c.key, key)
      should.equal(c.value, "5")
      should.equal(c.created_at, 5)
    })
    |> should.be_some

    db.stmts.config.set(key, "0", 0) |> should.be_error
  })
}

pub fn database_user_test() {
  use db <- use_db

  db.stmts.user.count() |> should.be_ok |> should.equal(0)
  db.stmts.user.search("alice") |> should.be_ok |> should.be_none
  db.stmts.user.search("bob") |> should.be_ok |> should.be_none

  db.stmts.user.search("alice@example.com") |> should.be_ok |> should.be_none
  db.stmts.user.search("bob@example.com") |> should.be_ok |> should.be_none

  db.stmts.user.insert_new("alice", "alice@example.com", "123456789012345")
  |> should.be_error
  db.stmts.user.count() |> should.be_ok |> should.equal(0)

  let alice =
    db.stmts.user.insert_new("alice", "alice@example.com", "1234567890123456")
    |> should.be_ok
  db.stmts.user.count() |> should.be_ok |> should.equal(1)

  db.stmts.user.search("alice")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)
  db.stmts.user.search("alIcE")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)
  db.stmts.user.search("alice@example.com")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)
  db.stmts.user.search("alice@examplE.com")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)

  let bob =
    db.stmts.user.insert_new(
      "bob",
      "bob@example.com",
      "Passwort with more than 16 chars.",
    )
    |> should.be_ok
  db.stmts.user.count() |> should.be_ok |> should.equal(2)

  bob |> should.not_equal(alice)
  bob.id |> should.not_equal(alice.id)

  db.stmts.user.search("bOb")
  |> should.be_ok
  |> should.be_some
  |> should.equal(bob)

  db.stmts.user.search("alice")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)

  db.stmts.user.insert_new("alice", "fake@example.com", "1234567890123456")
  |> should.be_error
  db.stmts.user.insert_new("fake", "alice@example.com", "1234567890123456")
  |> should.be_error
  db.stmts.user.insert_new(
    "charlie",
    "charlie(at)example.com",
    "1234567890123456",
  )
  |> should.be_error
  db.stmts.user.insert_new(
    "cha@rlie",
    "charlie@example.com",
    "1234567890123456",
  )
  |> should.be_error

  db.stmts.user.search_and_verify("alice", "1234567890123456")
  |> should.be_ok
  |> should.equal(alice)

  db.stmts.user.search_and_verify("bob", "1234567890123456")
  |> should.be_error

  let abby =
    db.stmts.user.update(user.User(..alice, username: "abby"), None)
    |> should.be_ok

  abby |> should.not_equal(alice)

  db.stmts.user.search("abby")
  |> should.be_ok
  |> should.be_some
  |> should.equal(abby)

  db.stmts.user.search("alice")
  |> should.be_ok
  |> should.be_none

  db.stmts.user.count() |> should.be_ok |> should.equal(2)
}
