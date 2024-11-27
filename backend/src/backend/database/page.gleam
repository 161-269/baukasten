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

pub type Statements {
  Statements(
    get: fn(Int) -> Result(Option(Page), Error),
    get_active_by_path: fn(String) -> Result(Option(Page), Error),
    get_all: fn() -> Result(Dict(String, List(Page)), Error),
    delete: fn(Int) -> Result(Nil, Error),
    insert_new: fn(String, String, Option(String), BitArray, Int) ->
      Result(Page, Error),
    update: fn(Page, Int) -> Result(Page, Error),
    set_widgets_json: fn(Int, BitArray, Int) -> Result(Page, Error),
    set_generated_html: fn(Int, Option(BitArray), Int) -> Result(Page, Error),
    set_generated_css: fn(Int, Option(BitArray), Int) -> Result(Page, Error),
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

pub fn statements(db: Connection) -> Result(Statements, Error) {
  use get <- result.try(get(db))
  use get_active_by_path <- result.try(get_active_by_path(db))
  use get_all <- result.try(get_all(db))
  use delete <- result.try(delete(db))
  use insert_new <- result.try(insert_new(db))
  use update <- result.try(update(db))
  use set_widgets_json <- result.try(set_widgets_json(db))
  use set_generated_html <- result.try(set_generated_html(db))
  use set_generated_css <- result.try(set_generated_css(db))

  Ok(Statements(
    get:,
    get_active_by_path:,
    get_all:,
    delete:,
    insert_new:,
    update:,
    set_widgets_json:,
    set_generated_html:,
    set_generated_css:,
  ))
}

fn get(db: Connection) -> Result(fn(Int) -> Result(Option(Page), Error), Error) {
  use select <- result.try(sqlight.prepare(
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
    decoder(),
  ))
  fn(id: Int) -> Result(Option(Page), Error) {
    sqlight.query_prepared(select, [sqlight.int(id)])
    |> result.map(fn(values) {
      case values {
        [] -> None
        [value, ..] -> Some(value)
      }
    })
  }
  |> Ok
}

fn get_active_by_path(
  db: Connection,
) -> Result(fn(String) -> Result(Option(Page), Error), Error) {
  fn(path: String) -> Result(Option(Page), Error) {
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
  |> Ok
}

fn get_all(
  db: Connection,
) -> Result(fn() -> Result(Dict(String, List(Page)), Error), Error) {
  use select <- result.try(sqlight.prepare(
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
    decoder(),
  ))
  fn() {
    use pages <- result.try(sqlight.query_prepared(select, []))

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
  |> Ok
}

fn delete(db: Connection) -> Result(fn(Int) -> Result(Nil, Error), Error) {
  use update <- result.try(sqlight.prepare(
    "
UPDATE
  \"page\"
SET
  \"deleted\" = 1
WHERE
  \"id\" = ?;
    ",
    db,
    dynamic.dynamic,
  ))
  fn(id: Int) -> Result(Nil, Error) {
    sqlight.query_prepared(update, [sqlight.int(id)])
    |> result.map(fn(_) { Nil })
  }
  |> Ok
}

fn insert_new(
  db: Connection,
) -> Result(
  fn(String, String, Option(String), BitArray, Int) -> Result(Page, Error),
  Error,
) {
  use insert <- result.try(sqlight.prepare(
    "
INSERT INTO
  \"page\"
  (\"path\", \"title\", \"description\", \"widgets_json\", \"created_at\", \"updated_at\", \"active\", \"deleted\")
VALUES
  (?, ?, ?, ?, ?, ?, 0, 0)
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
    decoder(),
  ))

  fn(
    path: String,
    title: String,
    description: Option(String),
    widgets_json: BitArray,
    now: Int,
  ) -> Result(Page, Error) {
    use page <- result.try(
      sqlight.query_prepared(insert, [
        sqlight.text(path),
        sqlight.text(title),
        sqlight.nullable(sqlight.text, description),
        sqlight.blob(widgets_json),
        sqlight.int(now),
        sqlight.int(now),
      ]),
    )

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
  |> Ok
}

fn update(db: Connection) -> Result(fn(Page, Int) -> Result(Page, Error), Error) {
  use update <- result.try(sqlight.prepare(
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
    decoder(),
  ))
  fn(page: Page, now: Int) -> Result(Page, Error) {
    use page <- result.try(
      sqlight.query_prepared(update, [
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
      ]),
    )

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
  |> Ok
}

fn set_widgets_json(
  db: Connection,
) -> Result(fn(Int, BitArray, Int) -> Result(Page, Error), Error) {
  use update <- result.try(sqlight.prepare(
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
    decoder(),
  ))
  fn(id: Int, widgets_json: BitArray, now: Int) -> Result(Page, Error) {
    use page <- result.try(
      sqlight.query_prepared(update, [
        sqlight.blob(widgets_json),
        sqlight.int(now),
        sqlight.int(id),
      ]),
    )

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
  |> Ok
}

fn set_generated_html(
  db: Connection,
) -> Result(fn(Int, Option(BitArray), Int) -> Result(Page, Error), Error) {
  use update <- result.try(sqlight.prepare(
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
    decoder(),
  ))
  fn(id: Int, generated_html: Option(BitArray), now: Int) -> Result(Page, Error) {
    use page <- result.try(
      sqlight.query_prepared(update, [
        sqlight.nullable(sqlight.blob, generated_html),
        sqlight.int(now),
        sqlight.int(id),
      ]),
    )

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
  |> Ok
}

fn set_generated_css(
  db: Connection,
) -> Result(fn(Int, Option(BitArray), Int) -> Result(Page, Error), Error) {
  use update <- result.try(sqlight.prepare(
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
    decoder(),
  ))
  fn(id: Int, generated_css: Option(BitArray), now: Int) -> Result(Page, Error) {
    use page <- result.try(
      sqlight.query_prepared(update, [
        sqlight.nullable(sqlight.blob, generated_css),
        sqlight.int(now),
        sqlight.int(id),
      ]),
    )

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
  |> Ok
}
