//// https://www.sqlite.org/lang.html

import chomp.{do, return}
import chomp/lexer.{type Token as ChompToken} as _
import chomp/span
import gleam/list
import gleam/option.{type Option, None, Some}
import immutype_lite/parser/lexer.{type Token}
import immutype_lite/parser/lexer/keyword

type Parser(value) =
  chomp.Parser(value, ParseError, Token, Nil)

pub type Explain {
  Explain
  ExplainQueryPlan
}

/// https://www.sqlite.org/lang.html
pub type SqlStatement {
  SqlStatement(explain: Option(Explain), statement: Statement)
}

/// https://www.sqlite.org/lang.html
pub type Statement {
  StatementSelect
  // https://www.sqlite.org/lang_select.html
}

pub type SelectStatement {
  SelectStatement(with: Option(List(CommonTableExpression)), recursive: Bool)
}

pub type CommonTableExpression {
  CommonTableExpression(
    table_name: String,
    column_names: Option(List(String)),
    materialized: Option(Bool),
    select_statement: SelectStatement,
  )
}

pub type ParseError {
  ExpectedIdentifier
  ExpectedKeyword(keyword.Keyword)
  ExpectedCommonTableExpression(inner: chomp.Error(ParseError, Token))
}

pub fn parse_sql_statement(
  tokens: List(ChompToken(Token)),
) -> Result(SqlStatement, ParseError) {
  let tokens = whitespace_filter(tokens)
  todo
}

pub fn parse_sql_statements(
  tokens: List(ChompToken(Token)),
) -> List(Result(SqlStatement, ParseError)) {
  todo
}

fn whitespace_filter(tokens: List(ChompToken(Token))) -> List(ChompToken(Token)) {
  list.filter(tokens, fn(token) {
    case token.value {
      lexer.Whitespace(_) -> False
      _ -> True
    }
  })
}

/// https://www.sqlite.org/lang_select.html
fn select_statement() -> Parser(SelectStatement) {
  use with <- do(chomp.optional(keyword(keyword.With)))
  use #(with, recursive) <- do(case with {
    None -> return(#(None, False))
    Some(_) -> {
      use recursive <- do(chomp.optional(keyword(keyword.Recursive)))
      use with <- do(non_empty_sequence(
        common_table_expression(),
        special(lexer.Comma),
      ))

      return(#(Some(with), option.is_some(recursive)))
    }
  })

  return(SelectStatement(with:, recursive:))
}

/// https://www.sqlite.org/syntax/common-table-expression.html
fn common_table_expression() -> Parser(CommonTableExpression) {
  {
    use table_name <- do(identifier())
    use left_paren <- do(chomp.optional(special(lexer.LeftParen)))
    use column_names <- do(case left_paren {
      Some(_) -> {
        use column_names <- do(chomp.sequence(
          identifier(),
          special(lexer.Comma),
        ))
        use _ <- do(special(lexer.RightParen))

        return(Some(column_names))
      }
      None -> return(None)
    })

    use _ <- do(keyword(keyword.As))

    use not <- do(chomp.optional(keyword(keyword.Not)))
    use materialized <- do(case not {
      None -> {
        use materialized <- do(chomp.optional(keyword(keyword.Materialized)))

        return(option.map(materialized, fn(_) { True }))
      }
      Some(_) -> {
        use _ <- do(keyword(keyword.Materialized))
        return(Some(False))
      }
    })

    use _ <- do(special(lexer.LeftParen))
    use select_statement <- do(select_statement())
    use _ <- do(special(lexer.RightParen))

    return(CommonTableExpression(
      table_name:,
      column_names:,
      materialized:,
      select_statement:,
    ))
  }
  |> chomp.map_error(fn(err) {
    chomp.Custom(ExpectedCommonTableExpression(err))
  })
}

fn list(
  start: Parser(x),
  item: Parser(a),
  delimiter: Parser(y),
  end: Parser(z),
) -> Parser(List(a)) {
  use _ <- do(start)

  use result <- do(chomp.sequence(item, delimiter))
  use _ <- do(end)

  return(result)
}

fn non_empty_sequence(item: Parser(a), delimiter: Parser(z)) -> Parser(List(a)) {
  use first <- do(item)

  use delimiter_set <- do(chomp.optional(delimiter))

  case delimiter_set {
    None -> return([first])
    Some(_) -> {
      use rest <- do(non_empty_sequence(item, delimiter))
      return([first, ..rest])
    }
  }
}

fn special(special: lexer.Speacial) -> Parser(span.Span) {
  chomp.token(lexer.Special(special))
}

fn keyword(keyword: keyword.Keyword) -> Parser(keyword.Keyword) {
  chomp.take_map(fn(token: Token) {
    case token {
      lexer.Keyword(_, keyword) -> Some(keyword)
      _ -> None
    }
  })
  |> chomp.or_error(ExpectedKeyword(keyword))
}

fn identifier() -> Parser(String) {
  chomp.take_map(fn(token: Token) {
    case token {
      lexer.Identifier(value) -> Some(value)
      lexer.Keyword(value, _) -> Some(value)
      _ -> None
    }
  })
  |> chomp.or_error(ExpectedIdentifier)
}
