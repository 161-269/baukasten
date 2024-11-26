import gleam/bit_array
import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/option.{type Option, None, Some}
import gleam/result
import sqlight.{type Connection, type Error}
import widgets/helper/dynamic_helper

pub type GeneratedFile {
  GeneratedFile(
    id: Int,
    key: String,
    size: Int,
    created_at: Int,
    data: BitArray,
  )
}

pub type Statements {
  Statements(
    get: fn(Int) -> Result(Option(GeneratedFile), Error),
    get_by_key: fn(String) -> Result(Option(GeneratedFile), Error),
    set: fn(String, Int, BitArray) -> Result(GeneratedFile, Error),
    set_or_generate: fn(String, fn() -> #(Int, BitArray)) ->
      Result(GeneratedFile, Error),
  )
}

pub fn decoder() -> fn(Dynamic) -> Result(GeneratedFile, List(DecodeError)) {
  dynamic.tuple5(
    dynamic.int,
    dynamic.string,
    dynamic.int,
    dynamic.int,
    dynamic.bit_array,
  )
  |> dynamic_helper.map(fn(value) {
    let #(id, key, size, created_at, data) = value
    Ok(GeneratedFile(id:, key:, size:, created_at:, data:))
  })
}

pub fn statements(db: Connection) -> Result(Statements, Error) {
  use get <- result.try(get(db))
  use get_by_key <- result.try(get_by_key(db))
  use set <- result.try(set(db))
  use set_or_generate <- result.try(set_or_generate(get_by_key, set))

  Ok(Statements(get:, get_by_key:, set:, set_or_generate:))
}

fn get(
  db: Connection,
) -> Result(fn(Int) -> Result(Option(GeneratedFile), Error), Error) {
  fn(id: Int) -> Result(Option(GeneratedFile), Error) {
    sqlight.query(
      "
SELECT
  \"id\",
  \"key\",
  \"size\",
  \"created_at\",
  \"data\"
FROM
  \"generated_file\"
WHERE
  \"id\" = ?;
        ",
      db,
      [sqlight.int(id)],
      decoder(),
    )
    |> result.map(fn(values) {
      case values {
        [] -> None
        [value, ..] -> Some(value)
      }
    })
  }
  |> Ok
}

fn get_by_key(
  db: Connection,
) -> Result(fn(String) -> Result(Option(GeneratedFile), Error), Error) {
  fn(key: String) -> Result(Option(GeneratedFile), Error) {
    sqlight.query(
      "
    SELECT
      \"id\",
      \"key\",
      \"size\",
      \"created_at\",
      \"data\"
    FROM
      \"generated_file\"
    WHERE
      \"key\" = ?;
        ",
      db,
      [sqlight.text(key)],
      decoder(),
    )
    |> result.map(fn(values) {
      case values {
        [] -> None
        [value, ..] -> Some(value)
      }
    })
  }
  |> Ok
}

fn set(
  db: Connection,
) -> Result(fn(String, Int, BitArray) -> Result(GeneratedFile, Error), Error) {
  fn(key: String, now: Int, data: BitArray) -> Result(GeneratedFile, Error) {
    sqlight.query(
      "
INSERT INTO
  \"generated_file\"
  (\"key\", \"size\", \"created_at\", \"data\")
VALUES
  (?, ?, ?, ?)
ON CONFLICT (\"key\") DO UPDATE SET
  \"size\" = EXCLUDED.\"size\",
  \"created_at\" = EXCLUDED.\"created_at\",
  \"data\" = EXCLUDED.\"data\"
RETURNING
  \"id\",
  \"key\",
  \"size\",
  \"created_at\",
  \"data\";
        ",
      db,
      [
        sqlight.text(key),
        sqlight.int(bit_array.byte_size(data)),
        sqlight.int(now),
        sqlight.blob(data),
      ],
      decoder(),
    )
    |> result.map(fn(values) {
      case values {
        [] ->
          Error(sqlight.SqlightError(
            sqlight.Notfound,
            "Could not find inserted file",
            -1,
          ))
        [value, ..] -> Ok(value)
      }
    })
    |> result.flatten
  }
  |> Ok
}

fn set_or_generate(
  get_by_key: fn(String) -> Result(Option(GeneratedFile), Error),
  set: fn(String, Int, BitArray) -> Result(GeneratedFile, Error),
) -> Result(
  fn(String, fn() -> #(Int, BitArray)) -> Result(GeneratedFile, Error),
  Error,
) {
  fn(key: String, generate: fn() -> #(Int, BitArray)) -> Result(
    GeneratedFile,
    Error,
  ) {
    use file <- result.try(get_by_key(key))
    case file {
      Some(file) -> Ok(file)
      None -> {
        let #(now, data) = generate()
        use file <- result.try(set(key, now, data))
        Ok(file)
      }
    }
  }
  |> Ok
}
