import gleeunit
import gleeunit/should
import immutype_lite/column
import immutype_lite/table
import immutype_lite/where

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  1
  |> should.equal(1)
}

pub fn column_test() {
  table.table2(
    "user",
    column.integer("id")
      |> column.set_auto_increment_primary_key
      |> column.set_unique,
    column.text("name"),
  )
  |> where.where2
  |> where.where2_c1(where.Equals(1))
}
