import backend/database.{type Connection}
import backend/database/user
import gleam/list
import gleam/option.{None}
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

fn use_db(callback: fn(Connection, Connection, Connection) -> a) -> Nil {
  let db =
    database.connect(None, 10, 60_000)
    |> should.be_ok

  database.connection(db, 200, fn(e) { e }, fn(connection1) {
    database.connection(db, 200, fn(e) { e }, fn(connection2) {
      database.connection(db, 200, fn(e) { e }, fn(connection3) {
        Ok(callback(connection1, connection2, connection3))
      })
    })
  })
  |> should.be_ok

  database.disconnect(db, 2000)
}

pub fn database_configuration_test() {
  use db1, db2, db3 <- use_db

  list.map(
    [
      #("test", db1, db2),
      #("a.test", db2, db3),
      #("b.test", db1, db3),
      #("a.test.a", db2, db1),
    ],
    fn(pair) {
      let #(key, db_a, db_b) = pair

      db_a.stmts.config.get(key)
      |> should.be_ok
      |> should.be_none

      db_b.stmts.config.set(key, "1", 1) |> should.be_ok
      db_a.stmts.config.get(key)
      |> should.be_ok
      |> option.map(fn(c) {
        should.equal(c.key, key)
        should.equal(c.value, "1")
        should.equal(c.created_at, 1)
      })
      |> should.be_some

      db_a.stmts.config.set(key, "3", 3) |> should.be_ok
      db_a.stmts.config.get(key)
      |> should.be_ok
      |> option.map(fn(c) {
        should.equal(c.key, key)
        should.equal(c.value, "3")
        should.equal(c.created_at, 3)
      })
      |> should.be_some

      db_b.stmts.config.set(key, "2", 2) |> should.be_ok
      db_b.stmts.config.get(key)
      |> should.be_ok
      |> option.map(fn(c) {
        should.equal(c.key, key)
        should.equal(c.value, "3")
        should.equal(c.created_at, 3)
      })
      |> should.be_some

      db_b.stmts.config.set(key, "5", 5) |> should.be_ok
      db_a.stmts.config.get(key)
      |> should.be_ok
      |> option.map(fn(c) {
        should.equal(c.key, key)
        should.equal(c.value, "5")
        should.equal(c.created_at, 5)
      })
      |> should.be_some

      db_a.stmts.config.set(key, "0", 0) |> should.be_ok
      db_b.stmts.config.get(key)
      |> should.be_ok
      |> option.map(fn(c) {
        should.equal(c.key, key)
        should.equal(c.value, "5")
        should.equal(c.created_at, 5)
      })
      |> should.be_some

      db_a.stmts.config.set(key, "0", 0) |> should.be_error
    },
  )
}

pub fn database_user_test() {
  use db_a, db_b, db_c <- use_db

  db_a.stmts.user.count() |> should.be_ok |> should.equal(0)
  db_b.stmts.user.search("alice") |> should.be_ok |> should.be_none
  db_c.stmts.user.search("bob") |> should.be_ok |> should.be_none

  db_c.stmts.user.search("alice@example.com") |> should.be_ok |> should.be_none
  db_b.stmts.user.search("bob@example.com") |> should.be_ok |> should.be_none

  db_a.stmts.user.insert_new("alice", "alice@example.com", "123456789012345")
  |> should.be_error
  db_b.stmts.user.count() |> should.be_ok |> should.equal(0)

  let alice =
    db_a.stmts.user.insert_new("alice", "alice@example.com", "1234567890123456")
    |> should.be_ok
  db_c.stmts.user.count() |> should.be_ok |> should.equal(1)

  db_c.stmts.user.search("alice")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)
  db_a.stmts.user.search("alIcE")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)
  db_b.stmts.user.search("alice@example.com")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)
  db_a.stmts.user.search("alice@examplE.com")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)

  let bob =
    db_c.stmts.user.insert_new(
      "bob",
      "bob@example.com",
      "Passwort with more than 16 chars.",
    )
    |> should.be_ok
  db_b.stmts.user.count() |> should.be_ok |> should.equal(2)

  bob |> should.not_equal(alice)
  bob.id |> should.not_equal(alice.id)

  db_b.stmts.user.search("bOb")
  |> should.be_ok
  |> should.be_some
  |> should.equal(bob)

  db_a.stmts.user.search("alice")
  |> should.be_ok
  |> should.be_some
  |> should.equal(alice)

  db_c.stmts.user.insert_new("alice", "fake@example.com", "1234567890123456")
  |> should.be_error
  db_c.stmts.user.insert_new("fake", "alice@example.com", "1234567890123456")
  |> should.be_error
  db_b.stmts.user.insert_new(
    "charlie",
    "charlie(at)example.com",
    "1234567890123456",
  )
  |> should.be_error
  db_a.stmts.user.insert_new(
    "cha@rlie",
    "charlie@example.com",
    "1234567890123456",
  )
  |> should.be_error

  db_b.stmts.user.search_and_verify("alice", "1234567890123456")
  |> should.be_ok
  |> should.equal(alice)

  db_a.stmts.user.search_and_verify("bob", "1234567890123456")
  |> should.be_error

  let abby =
    db_c.stmts.user.update(user.User(..alice, username: "abby"), None)
    |> should.be_ok

  abby |> should.not_equal(alice)

  db_b.stmts.user.search("abby")
  |> should.be_ok
  |> should.be_some
  |> should.equal(abby)

  db_a.stmts.user.search("alice")
  |> should.be_ok
  |> should.be_none

  db_b.stmts.user.count() |> should.be_ok |> should.equal(2)
}
