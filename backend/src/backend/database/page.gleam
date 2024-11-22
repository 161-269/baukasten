import gleam/dict.{type Dict}
import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string
import sqlight.{type Connection, type Error}

pub type Page {
  Page(
    id: Int,
    path: String,
    title: String,
    description: Option(String),
    widgets_json: BitArray,
    generated_html: Option(BitArray),
    generated_css: Option(BitArray),
    created_at: Int,
    updated_at: Int,
    active: Bool,
  )
}

pub fn decoder() -> fn(Dynamic) -> Result(Page, List(DecodeError)) {
  let id_decoder = dynamic.element(0, dynamic.int)
  let path_decoder = dynamic.element(1, dynamic.string)
  let title_decoder = dynamic.element(2, dynamic.string)
  let description_decoder = dynamic.element(3, dynamic.optional(dynamic.string))
  let widgets_json_decoder = dynamic.element(4, dynamic.bit_array)
  let generated_html_decoder =
    dynamic.element(5, dynamic.optional(dynamic.bit_array))
  let generated_css_decoder =
    dynamic.element(6, dynamic.optional(dynamic.bit_array))
  let created_at_decoder = dynamic.element(7, dynamic.int)
  let updated_at_decoder = dynamic.element(8, dynamic.int)
  let active_decoder = dynamic.element(9, sqlight.decode_bool)

  fn(value: Dynamic) -> Result(Page, List(DecodeError)) {
    let id = id_decoder(value)
    let path = path_decoder(value)
    let title = title_decoder(value)
    let description = description_decoder(value)
    let widgets_json = widgets_json_decoder(value)
    let generated_html = generated_html_decoder(value)
    let generated_css = generated_css_decoder(value)
    let created_at = created_at_decoder(value)
    let updated_at = updated_at_decoder(value)
    let active = active_decoder(value)

    case
      id,
      path,
      title,
      description,
      widgets_json,
      generated_html,
      generated_css,
      created_at,
      updated_at,
      active
    {
      Ok(id),
        Ok(path),
        Ok(title),
        Ok(description),
        Ok(widgets_json),
        Ok(generated_html),
        Ok(generated_css),
        Ok(created_at),
        Ok(updated_at),
        Ok(active)
      ->
        Ok(Page(
          id,
          path,
          title,
          description,
          widgets_json,
          generated_html,
          generated_css,
          created_at,
          updated_at,
          active,
        ))
      _, _, _, _, _, _, _, _, _, _ -> {
        let err = fn(result: Result(a, List(b))) -> List(b) {
          case result {
            Ok(_) -> []
            Error(error) -> error
          }
        }

        Error(
          list.flatten([
            err(id),
            err(path),
            err(title),
            err(description),
            err(widgets_json),
            err(generated_html),
            err(generated_css),
            err(created_at),
            err(updated_at),
            err(active),
          ]),
        )
      }
    }
  }
}

pub fn get(db: Connection, id: Int) -> Result(Option(Page), Error) {
  sqlight.query(
    "
SELECT
  \"id\",
  \"path\",
  \"title\",
  \"description\",
  \"widgets_json\",
  \"generated_html\",
  \"generated_css\",
  \"created_at\",
  \"updated_at\",
  \"active\"
FROM
  \"page\"
WHERE
  \"id\" = ?
  AND
  \"deleted\" = 0;
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

pub fn get_active_by_path(
  db: Connection,
  path: String,
) -> Result(Option(Page), Error) {
  sqlight.query(
    "
SELECT
  \"id\",
  \"path\",
  \"title\",
  \"description\",
  \"widgets_json\",
  \"generated_html\",
  \"generated_css\",
  \"created_at\",
  \"updated_at\",
  \"active\"
FROM
  \"page\"
WHERE
  \"deleted\" = 0
  AND
  \"active\" = 1
  AND 
  \"path\" = ?
ORDER BY
  \"updated_at\" DESC
LIMIT 1;
    ",
    db,
    [sqlight.text(path)],
    decoder(),
  )
  |> result.map(fn(values) {
    case values {
      [] -> None
      [value, ..] -> Some(value)
    }
  })
}

pub fn get_all(db: Connection) -> Result(Dict(String, List(Page)), Error) {
  use pages <- result.try(sqlight.query(
    "
SELECT
  \"id\",
  \"path\",
  \"title\",
  \"description\",
  \"widgets_json\",
  \"generated_html\",
  \"generated_css\",
  \"created_at\",
  \"updated_at\",
  \"active\"
FROM
  \"page\"
WHERE
  \"deleted\" = 0
ORDER BY
  \"updated_at\" ASC;
    ",
    db,
    [],
    decoder(),
  ))

  let pages =
    list.fold(pages, dict.new(), fn(acc, page) {
      let key = string.lowercase(page.path)

      let pages = case dict.get(acc, key) {
        Error(_) -> [page]
        Ok(pages) -> [page, ..pages]
      }

      dict.insert(acc, key, pages)
    })

  let pages =
    dict.fold(pages, dict.new(), fn(acc, _, pages) {
      case pages {
        [] -> acc
        [page, ..] -> dict.insert(acc, page.path, pages)
      }
    })

  Ok(pages)
}

pub fn delete(db: Connection, id: Int) -> Result(Nil, Error) {
  sqlight.query(
    "
UPDATE
  \"page\"
SET
  \"deleted\" = 1
WHERE
  \"id\" = ?;
    ",
    db,
    [sqlight.int(id)],
    dynamic.dynamic,
  )
  |> result.map(fn(_) { Nil })
}

pub fn insert_new(
  db: Connection,
  path: String,
  title: String,
  description: Option(String),
  widgets_json: BitArray,
  now: Int,
) -> Result(Page, Error) {
  use page <- result.try(sqlight.query(
    "
INSERT INTO
  \"page\"
  (\"path\", \"title\", \"description\", \"widgets_json\", \"created_at\", \"updated_at\", \"active\")
VALUES
  (?, ?, ?, ?, ?, ?, 0)
RETURNING
  \"id\",
  \"path\",
  \"title\",
  \"description\",
  \"widgets_json\",
  \"generated_html\",
  \"generated_css\",
  \"created_at\",
  \"updated_at\",
  \"active\";
      ",
    db,
    [
      sqlight.text(path),
      sqlight.text(title),
      sqlight.nullable(sqlight.text, description),
      sqlight.blob(widgets_json),
      sqlight.int(now),
      sqlight.int(now),
    ],
    decoder(),
  ))

  case page {
    [] ->
      Error(sqlight.SqlightError(
        sqlight.Notfound,
        "Could not find inserted page",
        -1,
      ))
    [page, ..] -> Ok(page)
  }
}

pub fn update(db: Connection, page: Page, now: Int) -> Result(Page, Error) {
  use page <- result.try(sqlight.query(
    "
UPDATE
  \"page\"
SET
  \"path\" = ?,
  \"title\" = ?,
  \"description\" = ?,
  \"widgets_json\" = ?,
  \"generated_html\" = ?,
  \"generated_css\" = ?,
  \"created_at\" = ?,
  \"updated_at\" = ?,
  \"active\" = ?
WHERE
  \"id\" = ?
RETURNING
  \"id\",
  \"path\",
  \"title\",
  \"description\",
  \"widgets_json\",
  \"generated_html\",
  \"generated_css\",
  \"created_at\",
  \"updated_at\",
  \"active\";
        ",
    db,
    [
      sqlight.text(page.path),
      sqlight.text(page.title),
      sqlight.nullable(sqlight.text, page.description),
      sqlight.blob(page.widgets_json),
      sqlight.nullable(sqlight.blob, page.generated_html),
      sqlight.nullable(sqlight.blob, page.generated_css),
      sqlight.int(page.created_at),
      sqlight.int(now),
      sqlight.bool(page.active),
      sqlight.int(page.id),
    ],
    decoder(),
  ))

  case page {
    [] ->
      Error(sqlight.SqlightError(
        sqlight.Notfound,
        "Could not find updated page",
        -1,
      ))
    [page, ..] -> Ok(page)
  }
}

pub fn set_widgets_json(
  db: Connection,
  id: Int,
  widgets_json: BitArray,
  now: Int,
) -> Result(Page, Error) {
  use page <- result.try(sqlight.query(
    "
UPDATE
  \"page\"
SET
  \"widgets_json\" = ?,
  \"updated_at\" = ?
WHERE
  \"id\" = ?
RETURNING
  \"id\",
  \"path\",
  \"title\",
  \"description\",
  \"widgets_json\",
  \"generated_html\",
  \"generated_css\",
  \"created_at\",
  \"updated_at\",    
  \"active\";
    ",
    db,
    [sqlight.blob(widgets_json), sqlight.int(now), sqlight.int(id)],
    decoder(),
  ))

  case page {
    [] ->
      Error(sqlight.SqlightError(
        sqlight.Notfound,
        "Could not find updated page",
        -1,
      ))
    [page, ..] -> Ok(page)
  }
}

pub fn set_generated_html(
  db: Connection,
  id: Int,
  generated_html: Option(BitArray),
  now: Int,
) -> Result(Page, Error) {
  use page <- result.try(sqlight.query(
    "
UPDATE
  \"page\"
SET
  \"generated_html\" = ?,
  \"updated_at\" = ?
WHERE
  \"id\" = ?
RETURNING
  \"id\",
  \"path\",
  \"title\",
  \"description\",
  \"widgets_json\",
  \"generated_html\",
  \"generated_css\",
  \"created_at\",
  \"updated_at\",
  \"active\";
    ",
    db,
    [
      sqlight.nullable(sqlight.blob, generated_html),
      sqlight.int(now),
      sqlight.int(id),
    ],
    decoder(),
  ))

  case page {
    [] ->
      Error(sqlight.SqlightError(
        sqlight.Notfound,
        "Could not find updated page",
        -1,
      ))
    [page, ..] -> Ok(page)
  }
}

pub fn set_generated_css(
  db: Connection,
  id: Int,
  generated_css: Option(BitArray),
  now: Int,
) -> Result(Page, Error) {
  use page <- result.try(sqlight.query(
    "
UPDATE
  \"page\"
SET
  \"generated_css\" = ?,
  \"updated_at\" = ?
WHERE
  \"id\" = ?
RETURNING
  \"id\",
  \"path\",
  \"title\",
  \"description\",
  \"widgets_json\",
  \"generated_html\",
  \"generated_css\",
  \"created_at\",
  \"updated_at\",
  \"active\";
    ",
    db,
    [
      sqlight.nullable(sqlight.blob, generated_css),
      sqlight.int(now),
      sqlight.int(id),
    ],
    decoder(),
  ))

  case page {
    [] ->
      Error(sqlight.SqlightError(
        sqlight.Notfound,
        "Could not find updated page",
        -1,
      ))
    [page, ..] -> Ok(page)
  }
}
