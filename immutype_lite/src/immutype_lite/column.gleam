import gleam/option.{type Option, None, Some}
import immutype_lite/types.{type Type}

pub type PrimaryKeyType {
  NotPrimaryKey
  PrimaryKey
  AutoIncrementPrimaryKey
}

pub type Column(base_type, value_type) {
  Column(
    name: String,
    column_type: Type(base_type, value_type),
    primary_key: PrimaryKeyType,
    unique: Bool,
    default_value: Option(base_type),
  )
}

pub fn new(
  name: String,
  column_type: Type(base_type, value_type),
) -> Column(base_type, value_type) {
  Column(
    name: name,
    column_type: column_type,
    primary_key: NotPrimaryKey,
    unique: False,
    default_value: None,
  )
}

pub fn integer(name: String) -> Column(Int, Int) {
  new(name, types.integer())
}

pub fn nullable_integer(name: String) -> Column(Int, Option(Int)) {
  new(name, types.nullable_integer())
}

pub fn real(name: String) -> Column(Float, Float) {
  new(name, types.real())
}

pub fn nullable_real(name: String) -> Column(Float, Option(Float)) {
  new(name, types.nullable_real())
}

pub fn text(name: String) -> Column(String, String) {
  new(name, types.text())
}

pub fn nullable_text(name: String) -> Column(String, Option(String)) {
  new(name, types.nullable_text())
}

pub fn blob(name: String) -> Column(BitArray, BitArray) {
  new(name, types.blob())
}

pub fn nullable_blob(name: String) -> Column(BitArray, Option(BitArray)) {
  new(name, types.nullable_blob())
}

pub fn bool(name: String) -> Column(Bool, Bool) {
  new(name, types.bool())
}

pub fn nullable_bool(name: String) -> Column(Bool, Option(Bool)) {
  new(name, types.nullable_bool())
}

pub fn rename(column, name: String) -> Column(base_type, value_type) {
  Column(..column, name: name)
}

pub fn set_primary_key(
  column: Column(base_type, value_type),
) -> Column(base_type, value_type) {
  Column(..column, primary_key: PrimaryKey)
}

pub fn unset_primary_key(
  column: Column(base_type, value_type),
) -> Column(base_type, value_type) {
  Column(..column, primary_key: NotPrimaryKey)
}

pub fn set_auto_increment_primary_key(
  column: Column(base_type, value_type),
) -> Column(base_type, value_type) {
  Column(..column, primary_key: AutoIncrementPrimaryKey)
}

pub fn set_unique(
  column: Column(base_type, value_type),
) -> Column(base_type, value_type) {
  Column(..column, unique: True)
}

pub fn unset_unique(
  column: Column(base_type, value_type),
) -> Column(base_type, value_type) {
  Column(..column, unique: False)
}

pub fn set_default_value(
  column: Column(base_type, value_type),
  default_value: base_type,
) -> Column(base_type, value_type) {
  Column(..column, default_value: Some(default_value))
}

pub fn unset_default_value(
  column: Column(base_type, value_type),
) -> Column(base_type, value_type) {
  Column(..column, default_value: None)
}
