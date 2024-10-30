import immutype_lite/column.{type Column}

pub type Table1(b1, v1) {
  Table1(column: Column(b1, v1))
}

pub type Table2(b1, v1, b2, v2) {
  Table2(column1: Column(b1, v1), column2: Column(b2, v2))
}

pub type Table3(b1, v1, b2, v2, b3, v3) {
  Table3(
    column1: Column(b1, v1),
    column2: Column(b2, v2),
    column3: Column(b3, v3),
  )
}

pub type Table4(b1, v1, b2, v2, b3, v3, b4, v4) {
  Table4(
    column1: Column(b1, v1),
    column2: Column(b2, v2),
    column3: Column(b3, v3),
    column4: Column(b4, v4),
  )
}

pub type Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5) {
  Table5(
    column1: Column(b1, v1),
    column2: Column(b2, v2),
    column3: Column(b3, v3),
    column4: Column(b4, v4),
    column5: Column(b5, v5),
  )
}

pub type Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6) {
  Table6(
    column1: Column(b1, v1),
    column2: Column(b2, v2),
    column3: Column(b3, v3),
    column4: Column(b4, v4),
    column5: Column(b5, v5),
    column6: Column(b6, v6),
  )
}

pub type Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7) {
  Table7(
    column1: Column(b1, v1),
    column2: Column(b2, v2),
    column3: Column(b3, v3),
    column4: Column(b4, v4),
    column5: Column(b5, v5),
    column6: Column(b6, v6),
    column7: Column(b7, v7),
  )
}

pub type Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8) {
  Table8(
    column1: Column(b1, v1),
    column2: Column(b2, v2),
    column3: Column(b3, v3),
    column4: Column(b4, v4),
    column5: Column(b5, v5),
    column6: Column(b6, v6),
    column7: Column(b7, v7),
    column8: Column(b8, v8),
  )
}

pub type Table9(
  b1,
  v1,
  b2,
  v2,
  b3,
  v3,
  b4,
  v4,
  b5,
  v5,
  b6,
  v6,
  b7,
  v7,
  b8,
  v8,
  b9,
  v9,
) {
  Table9(
    column1: Column(b1, v1),
    column2: Column(b2, v2),
    column3: Column(b3, v3),
    column4: Column(b4, v4),
    column5: Column(b5, v5),
    column6: Column(b6, v6),
    column7: Column(b7, v7),
    column8: Column(b8, v8),
    column9: Column(b9, v9),
  )
}

pub opaque type Table(table) {
  Table(name: String, table: table)
}

pub fn name(table: Table(table)) -> String {
  table.name
}

pub fn columns(table: Table(table)) -> table {
  table.table
}

pub fn table1(name: String, column: Column(b1, v1)) -> Table(Table1(b1, v1)) {
  Table(name: name, table: Table1(column:))
}

pub fn table2(
  name: String,
  column1: Column(b1, v1),
  column2: Column(b2, v2),
) -> Table(Table2(b1, v1, b2, v2)) {
  Table(name: name, table: Table2(column1:, column2:))
}

pub fn table3(
  name: String,
  column1: Column(b1, v1),
  column2: Column(b2, v2),
  column3: Column(b3, v3),
) -> Table(Table3(b1, v1, b2, v2, b3, v3)) {
  Table(name: name, table: Table3(column1:, column2:, column3:))
}

pub fn table4(
  name: String,
  column1: Column(b1, v1),
  column2: Column(b2, v2),
  column3: Column(b3, v3),
  column4: Column(b4, v4),
) -> Table(Table4(b1, v1, b2, v2, b3, v3, b4, v4)) {
  Table(name: name, table: Table4(column1:, column2:, column3:, column4:))
}

pub fn table5(
  name: String,
  column1: Column(b1, v1),
  column2: Column(b2, v2),
  column3: Column(b3, v3),
  column4: Column(b4, v4),
  column5: Column(b5, v5),
) -> Table(Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5)) {
  Table(
    name: name,
    table: Table5(column1:, column2:, column3:, column4:, column5:),
  )
}

pub fn table6(
  name: String,
  column1: Column(b1, v1),
  column2: Column(b2, v2),
  column3: Column(b3, v3),
  column4: Column(b4, v4),
  column5: Column(b5, v5),
  column6: Column(b6, v6),
) -> Table(Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6)) {
  Table(
    name: name,
    table: Table6(column1:, column2:, column3:, column4:, column5:, column6:),
  )
}

pub fn table7(
  name: String,
  column1: Column(b1, v1),
  column2: Column(b2, v2),
  column3: Column(b3, v3),
  column4: Column(b4, v4),
  column5: Column(b5, v5),
  column6: Column(b6, v6),
  column7: Column(b7, v7),
) -> Table(Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7)) {
  Table(
    name: name,
    table: Table7(
      column1:,
      column2:,
      column3:,
      column4:,
      column5:,
      column6:,
      column7:,
    ),
  )
}

pub fn table8(
  name: String,
  column1: Column(b1, v1),
  column2: Column(b2, v2),
  column3: Column(b3, v3),
  column4: Column(b4, v4),
  column5: Column(b5, v5),
  column6: Column(b6, v6),
  column7: Column(b7, v7),
  column8: Column(b8, v8),
) -> Table(
  Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8),
) {
  Table(
    name: name,
    table: Table8(
      column1:,
      column2:,
      column3:,
      column4:,
      column5:,
      column6:,
      column7:,
      column8:,
    ),
  )
}

pub fn table9(
  name: String,
  column1: Column(b1, v1),
  column2: Column(b2, v2),
  column3: Column(b3, v3),
  column4: Column(b4, v4),
  column5: Column(b5, v5),
  column6: Column(b6, v6),
  column7: Column(b7, v7),
  column8: Column(b8, v8),
  column9: Column(b9, v9),
) -> Table(
  Table9(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8, b9, v9),
) {
  Table(
    name: name,
    table: Table9(
      column1:,
      column2:,
      column3:,
      column4:,
      column5:,
      column6:,
      column7:,
      column8:,
      column9:,
    ),
  )
}
