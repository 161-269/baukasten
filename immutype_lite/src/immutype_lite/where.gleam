import gleam/option.{type Option, None, Some}
import immutype_lite/table

pub type Constraint(base_type) {
  And(left: Constraint(base_type), right: List(Constraint(base_type)))
  Or(left: Constraint(base_type), right: List(Constraint(base_type)))
  Not(constraint: Constraint(base_type))
  Equals(value: base_type)
  LessThan(value: base_type)
  GreaterThan(value: base_type)
  LessThanOrEqual(value: base_type)
  GreaterThanOrEqual(value: base_type)
  In(values: List(base_type))
  IsNull
}

pub type Table1(b1, v1) {
  Table1(
    table: table.Table(table.Table1(b1, v1)),
    constraint: Option(Constraint(b1)),
  )
}

pub type Table2(b1, v1, b2, v2) {
  Table2(
    table: table.Table(table.Table2(b1, v1, b2, v2)),
    constraint1: Option(Constraint(b1)),
    constraint2: Option(Constraint(b2)),
  )
}

pub type Table3(b1, v1, b2, v2, b3, v3) {
  Table3(
    table: table.Table(table.Table3(b1, v1, b2, v2, b3, v3)),
    constraint1: Option(Constraint(b1)),
    constraint2: Option(Constraint(b2)),
    constraint3: Option(Constraint(b3)),
  )
}

pub type Table4(b1, v1, b2, v2, b3, v3, b4, v4) {
  Table4(
    table: table.Table(table.Table4(b1, v1, b2, v2, b3, v3, b4, v4)),
    constraint1: Option(Constraint(b1)),
    constraint2: Option(Constraint(b2)),
    constraint3: Option(Constraint(b3)),
    constraint4: Option(Constraint(b4)),
  )
}

pub type Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5) {
  Table5(
    table: table.Table(table.Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5)),
    constraint1: Option(Constraint(b1)),
    constraint2: Option(Constraint(b2)),
    constraint3: Option(Constraint(b3)),
    constraint4: Option(Constraint(b4)),
    constraint5: Option(Constraint(b5)),
  )
}

pub type Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6) {
  Table6(
    table: table.Table(
      table.Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6),
    ),
    constraint1: Option(Constraint(b1)),
    constraint2: Option(Constraint(b2)),
    constraint3: Option(Constraint(b3)),
    constraint4: Option(Constraint(b4)),
    constraint5: Option(Constraint(b5)),
    constraint6: Option(Constraint(b6)),
  )
}

pub type Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7) {
  Table7(
    table: table.Table(
      table.Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7),
    ),
    constraint1: Option(Constraint(b1)),
    constraint2: Option(Constraint(b2)),
    constraint3: Option(Constraint(b3)),
    constraint4: Option(Constraint(b4)),
    constraint5: Option(Constraint(b5)),
    constraint6: Option(Constraint(b6)),
    constraint7: Option(Constraint(b7)),
  )
}

pub type Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8) {
  Table8(
    table: table.Table(
      table.Table8(
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
      ),
    ),
    constraint1: Option(Constraint(b1)),
    constraint2: Option(Constraint(b2)),
    constraint3: Option(Constraint(b3)),
    constraint4: Option(Constraint(b4)),
    constraint5: Option(Constraint(b5)),
    constraint6: Option(Constraint(b6)),
    constraint7: Option(Constraint(b7)),
    constraint8: Option(Constraint(b8)),
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
    table: table.Table(
      table.Table9(
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
      ),
    ),
    constraint1: Option(Constraint(b1)),
    constraint2: Option(Constraint(b2)),
    constraint3: Option(Constraint(b3)),
    constraint4: Option(Constraint(b4)),
    constraint5: Option(Constraint(b5)),
    constraint6: Option(Constraint(b6)),
    constraint7: Option(Constraint(b7)),
    constraint8: Option(Constraint(b8)),
    constraint9: Option(Constraint(b9)),
  )
}

pub fn where1(table: table.Table(table.Table1(b1, v1))) -> Table1(b1, v1) {
  Table1(table: table, constraint: None)
}

pub fn where2(
  table: table.Table(table.Table2(b1, v1, b2, v2)),
) -> Table2(b1, v1, b2, v2) {
  Table2(table: table, constraint1: None, constraint2: None)
}

pub fn where3(
  table: table.Table(table.Table3(b1, v1, b2, v2, b3, v3)),
) -> Table3(b1, v1, b2, v2, b3, v3) {
  Table3(table: table, constraint1: None, constraint2: None, constraint3: None)
}

pub fn where4(
  table: table.Table(table.Table4(b1, v1, b2, v2, b3, v3, b4, v4)),
) -> Table4(b1, v1, b2, v2, b3, v3, b4, v4) {
  Table4(
    table: table,
    constraint1: None,
    constraint2: None,
    constraint3: None,
    constraint4: None,
  )
}

pub fn where5(
  table: table.Table(table.Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5)),
) -> Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5) {
  Table5(
    table: table,
    constraint1: None,
    constraint2: None,
    constraint3: None,
    constraint4: None,
    constraint5: None,
  )
}

pub fn where6(
  table: table.Table(
    table.Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6),
  ),
) -> Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6) {
  Table6(
    table: table,
    constraint1: None,
    constraint2: None,
    constraint3: None,
    constraint4: None,
    constraint5: None,
    constraint6: None,
  )
}

pub fn where7(
  table: table.Table(
    table.Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7),
  ),
) -> Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7) {
  Table7(
    table: table,
    constraint1: None,
    constraint2: None,
    constraint3: None,
    constraint4: None,
    constraint5: None,
    constraint6: None,
    constraint7: None,
  )
}

pub fn where8(
  table: table.Table(
    table.Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8),
  ),
) -> Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8) {
  Table8(
    table: table,
    constraint1: None,
    constraint2: None,
    constraint3: None,
    constraint4: None,
    constraint5: None,
    constraint6: None,
    constraint7: None,
    constraint8: None,
  )
}

pub fn where9(
  table: table.Table(
    table.Table9(
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
    ),
  ),
) -> Table9(
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
    table: table,
    constraint1: None,
    constraint2: None,
    constraint3: None,
    constraint4: None,
    constraint5: None,
    constraint6: None,
    constraint7: None,
    constraint8: None,
    constraint9: None,
  )
}

pub fn where1_c1(
  table: Table1(b1, v1),
  constraint: Constraint(b1),
) -> Table1(b1, v1) {
  Table1(..table, constraint: Some(constraint))
}

pub fn where2_c1(
  table: Table2(b1, v1, b2, v2),
  constraint1: Constraint(b1),
) -> Table2(b1, v1, b2, v2) {
  Table2(..table, constraint1: Some(constraint1))
}

pub fn where2_c2(
  table: Table2(b1, v1, b2, v2),
  constraint2: Constraint(b2),
) -> Table2(b1, v1, b2, v2) {
  Table2(..table, constraint2: Some(constraint2))
}

pub fn where3_c1(
  table: Table3(b1, v1, b2, v2, b3, v3),
  constraint1: Constraint(b1),
) -> Table3(b1, v1, b2, v2, b3, v3) {
  Table3(..table, constraint1: Some(constraint1))
}

pub fn where3_c2(
  table: Table3(b1, v1, b2, v2, b3, v3),
  constraint2: Constraint(b2),
) -> Table3(b1, v1, b2, v2, b3, v3) {
  Table3(..table, constraint2: Some(constraint2))
}

pub fn where3_c3(
  table: Table3(b1, v1, b2, v2, b3, v3),
  constraint3: Constraint(b3),
) -> Table3(b1, v1, b2, v2, b3, v3) {
  Table3(..table, constraint3: Some(constraint3))
}

pub fn where4_c1(
  table: Table4(b1, v1, b2, v2, b3, v3, b4, v4),
  constraint1: Constraint(b1),
) -> Table4(b1, v1, b2, v2, b3, v3, b4, v4) {
  Table4(..table, constraint1: Some(constraint1))
}

pub fn where4_c2(
  table: Table4(b1, v1, b2, v2, b3, v3, b4, v4),
  constraint2: Constraint(b2),
) -> Table4(b1, v1, b2, v2, b3, v3, b4, v4) {
  Table4(..table, constraint2: Some(constraint2))
}

pub fn where4_c3(
  table: Table4(b1, v1, b2, v2, b3, v3, b4, v4),
  constraint3: Constraint(b3),
) -> Table4(b1, v1, b2, v2, b3, v3, b4, v4) {
  Table4(..table, constraint3: Some(constraint3))
}

pub fn where4_c4(
  table: Table4(b1, v1, b2, v2, b3, v3, b4, v4),
  constraint4: Constraint(b4),
) -> Table4(b1, v1, b2, v2, b3, v3, b4, v4) {
  Table4(..table, constraint4: Some(constraint4))
}

pub fn where5_c1(
  table: Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5),
  constraint1: Constraint(b1),
) -> Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5) {
  Table5(..table, constraint1: Some(constraint1))
}

pub fn where5_c2(
  table: Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5),
  constraint2: Constraint(b2),
) -> Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5) {
  Table5(..table, constraint2: Some(constraint2))
}

pub fn where5_c3(
  table: Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5),
  constraint3: Constraint(b3),
) -> Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5) {
  Table5(..table, constraint3: Some(constraint3))
}

pub fn where5_c4(
  table: Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5),
  constraint4: Constraint(b4),
) -> Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5) {
  Table5(..table, constraint4: Some(constraint4))
}

pub fn where5_c5(
  table: Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5),
  constraint5: Constraint(b5),
) -> Table5(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5) {
  Table5(..table, constraint5: Some(constraint5))
}

pub fn where6_c1(
  table: Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6),
  constraint1: Constraint(b1),
) -> Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6) {
  Table6(..table, constraint1: Some(constraint1))
}

pub fn where6_c2(
  table: Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6),
  constraint2: Constraint(b2),
) -> Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6) {
  Table6(..table, constraint2: Some(constraint2))
}

pub fn where6_c3(
  table: Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6),
  constraint3: Constraint(b3),
) -> Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6) {
  Table6(..table, constraint3: Some(constraint3))
}

pub fn where6_c4(
  table: Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6),
  constraint4: Constraint(b4),
) -> Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6) {
  Table6(..table, constraint4: Some(constraint4))
}

pub fn where6_c5(
  table: Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6),
  constraint5: Constraint(b5),
) -> Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6) {
  Table6(..table, constraint5: Some(constraint5))
}

pub fn where6_c6(
  table: Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6),
  constraint6: Constraint(b6),
) -> Table6(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6) {
  Table6(..table, constraint6: Some(constraint6))
}

pub fn where7_c1(
  table: Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7),
  constraint1: Constraint(b1),
) -> Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7) {
  Table7(..table, constraint1: Some(constraint1))
}

pub fn where7_c2(
  table: Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7),
  constraint2: Constraint(b2),
) -> Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7) {
  Table7(..table, constraint2: Some(constraint2))
}

pub fn where7_c3(
  table: Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7),
  constraint3: Constraint(b3),
) -> Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7) {
  Table7(..table, constraint3: Some(constraint3))
}

pub fn where7_c4(
  table: Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7),
  constraint4: Constraint(b4),
) -> Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7) {
  Table7(..table, constraint4: Some(constraint4))
}

pub fn where7_c5(
  table: Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7),
  constraint5: Constraint(b5),
) -> Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7) {
  Table7(..table, constraint5: Some(constraint5))
}

pub fn where7_c6(
  table: Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7),
  constraint6: Constraint(b6),
) -> Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7) {
  Table7(..table, constraint6: Some(constraint6))
}

pub fn where7_c7(
  table: Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7),
  constraint7: Constraint(b7),
) -> Table7(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7) {
  Table7(..table, constraint7: Some(constraint7))
}

pub fn where8_c1(
  table: Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8),
  constraint1: Constraint(b1),
) -> Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8) {
  Table8(..table, constraint1: Some(constraint1))
}

pub fn where8_c2(
  table: Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8),
  constraint2: Constraint(b2),
) -> Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8) {
  Table8(..table, constraint2: Some(constraint2))
}

pub fn where8_c3(
  table: Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8),
  constraint3: Constraint(b3),
) -> Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8) {
  Table8(..table, constraint3: Some(constraint3))
}

pub fn where8_c4(
  table: Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8),
  constraint4: Constraint(b4),
) -> Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8) {
  Table8(..table, constraint4: Some(constraint4))
}

pub fn where8_c5(
  table: Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8),
  constraint5: Constraint(b5),
) -> Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8) {
  Table8(..table, constraint5: Some(constraint5))
}

pub fn where8_c6(
  table: Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8),
  constraint6: Constraint(b6),
) -> Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8) {
  Table8(..table, constraint6: Some(constraint6))
}

pub fn where8_c7(
  table: Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8),
  constraint7: Constraint(b7),
) -> Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8) {
  Table8(..table, constraint7: Some(constraint7))
}

pub fn where8_c8(
  table: Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8),
  constraint8: Constraint(b8),
) -> Table8(b1, v1, b2, v2, b3, v3, b4, v4, b5, v5, b6, v6, b7, v7, b8, v8) {
  Table8(..table, constraint8: Some(constraint8))
}

pub fn where9_c1(
  table: Table9(
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
  ),
  constraint1: Constraint(b1),
) -> Table9(
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
  Table9(..table, constraint1: Some(constraint1))
}

pub fn where9_c2(
  table: Table9(
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
  ),
  constraint2: Constraint(b2),
) -> Table9(
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
  Table9(..table, constraint2: Some(constraint2))
}

pub fn where9_c3(
  table: Table9(
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
  ),
  constraint3: Constraint(b3),
) -> Table9(
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
  Table9(..table, constraint3: Some(constraint3))
}

pub fn where9_c4(
  table: Table9(
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
  ),
  constraint4: Constraint(b4),
) -> Table9(
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
  Table9(..table, constraint4: Some(constraint4))
}

pub fn where9_c5(
  table: Table9(
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
  ),
  constraint5: Constraint(b5),
) -> Table9(
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
  Table9(..table, constraint5: Some(constraint5))
}

pub fn where9_c6(
  table: Table9(
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
  ),
  constraint6: Constraint(b6),
) -> Table9(
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
  Table9(..table, constraint6: Some(constraint6))
}

pub fn where9_c7(
  table: Table9(
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
  ),
  constraint7: Constraint(b7),
) -> Table9(
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
  Table9(..table, constraint7: Some(constraint7))
}

pub fn where9_c8(
  table: Table9(
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
  ),
  constraint8: Constraint(b8),
) -> Table9(
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
  Table9(..table, constraint8: Some(constraint8))
}

pub fn where9_c9(
  table: Table9(
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
  ),
  constraint9: Constraint(b9),
) -> Table9(
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
  Table9(..table, constraint9: Some(constraint9))
}
