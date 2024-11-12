//// https://www.sqlite.org/lang.html

import chomp.{do, return}
import chomp/lexer.{type Error as ChompError, type Token as ChompToken} as chomp_lexer
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

pub type SelectStatement

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
fn select_statement_parser() -> Parser(SelectStatement) {
  use _ <- do(keyword_parser(keyword.Select))
  todo
}

/// https://www.sqlite.org/syntax/common-table-expression.html
fn common_table_expression_parser() -> Parser(CommonTableExpression) {
  {
    use table_name <- do(identifier_parser())
    use left_paren <- do(chomp.optional(special_parser(lexer.LeftParen)))
    use column_names <- do(case left_paren {
      Some(_) -> {
        use column_names <- do(chomp.sequence(
          identifier_parser(),
          special_parser(lexer.Comma),
        ))
        use _ <- do(special_parser(lexer.RightParen))

        return(Some(column_names))
      }
      None -> return(None)
    })

    use _ <- do(keyword_parser(keyword.As))

    use not <- do(chomp.optional(keyword_parser(keyword.Not)))
    use materialized <- do(case not {
      None -> {
        use materialized <- do(
          chomp.optional(keyword_parser(keyword.Materialized)),
        )

        return(option.map(materialized, fn(_) { True }))
      }
      Some(_) -> {
        use _ <- do(keyword_parser(keyword.Materialized))
        return(Some(False))
      }
    })

    use _ <- do(special_parser(lexer.LeftParen))
    use select_statement <- do(select_statement_parser())
    use _ <- do(special_parser(lexer.RightParen))

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

fn list_parser(
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

fn special_parser(special: lexer.Speacial) -> Parser(span.Span) {
  chomp.token(lexer.Special(special))
}

fn keyword_parser(keyword: keyword.Keyword) -> Parser(keyword.Keyword) {
  chomp.take_map(fn(token: Token) {
    case token {
      lexer.Keyword(_, keyword) -> Some(keyword)
      _ -> None
    }
  })
  |> chomp.or_error(ExpectedKeyword(keyword))
}

fn identifier_parser() -> Parser(String) {
  chomp.take_map(fn(token: Token) {
    case token {
      lexer.Identifier(value) -> Some(value)
      lexer.Keyword(value, _) -> Some(value)
      _ -> None
    }
  })
  |> chomp.or_error(ExpectedIdentifier)
}
