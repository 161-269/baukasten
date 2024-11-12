import chomp/lexer.{type Matcher, Keep, NoMatch}
import gleam/list
import gleam/regex
import gleam/string
import immutype_lite/parser/helper

/// https://www.sqlite.org/lang_keywords.html
pub type Keyword {
  Abort
  Action
  Add
  After
  All
  Alter
  Always
  Analyze
  And
  As
  Asc
  Attach
  Autoincrement
  Before
  Begin
  Between
  Blob
  By
  Cascade
  Case
  Cast
  Check
  Collate
  Column
  Commit
  Conflict
  Constraint
  Create
  Cross
  Current
  CurrentDate
  CurrentTime
  CurrentTimestamp
  Database
  Default
  Deferrable
  Deferred
  Delete
  Desc
  Detach
  Distinct
  Do
  Drop
  Each
  Else
  End
  Escape
  Except
  Exclude
  Exclusive
  Exists
  Explain
  Fail
  Filter
  First
  Follwoing
  For
  Foreign
  From
  Full
  Generated
  Glob
  Group
  Groups
  Having
  If
  Ignore
  Immediate
  In
  Index
  Indexed
  Initially
  Inner
  Insert
  Instead
  Integer
  Intersect
  Into
  Is
  Isnull
  Join
  Key
  Last
  Left
  Like
  Limit
  Match
  Materialized
  Natural
  No
  Not
  Nothing
  Notnull
  Null
  Nulls
  Numeric
  Of
  Offset
  On
  Or
  Order
  Others
  Outer
  Over
  Partition
  Plan
  Pragma
  Precending
  Primary
  Query
  Raise
  Range
  Real
  Recursive
  References
  Regexp
  Reindex
  Release
  Rename
  Replace
  Restrict
  Returning
  Right
  Rollback
  Row
  Rows
  Savepoint
  Select
  Set
  Table
  Temp
  Temporary
  Text
  Then
  Ties
  To
  Transaction
  Trigger
  Unbounded
  Union
  Unique
  Update
  Using
  Vacuum
  Values
  View
  Virtual
  When
  Where
  Window
  With
  Without
}

fn keywords() -> List(#(String, Keyword)) {
  [
    #("ABORT", Abort),
    #("ACTION", Action),
    #("ADD", Add),
    #("AFTER", After),
    #("ALL", All),
    #("ALTER", Alter),
    #("ALWAYS", Always),
    #("ANALYZE", Analyze),
    #("AND", And),
    #("AS", As),
    #("ASC", Asc),
    #("ATTACH", Attach),
    #("AUTOINCREMENT", Autoincrement),
    #("BEFORE", Before),
    #("BEGIN", Begin),
    #("BETWEEN", Between),
    #("BLOB", Blob),
    #("BY", By),
    #("CASCADE", Cascade),
    #("CASE", Case),
    #("CAST", Cast),
    #("CHECK", Check),
    #("COLLATE", Collate),
    #("COLUMN", Column),
    #("COMMIT", Commit),
    #("CONFLICT", Conflict),
    #("CONSTRAINT", Constraint),
    #("CREATE", Create),
    #("CROSS", Cross),
    #("CURRENT", Current),
    #("CURRENT_DATE", CurrentDate),
    #("CURRENT_TIME", CurrentTime),
    #("CURRENT_TIMESTAMP", CurrentTimestamp),
    #("DATABASE", Database),
    #("DEFAULT", Default),
    #("DEFERRABLE", Deferrable),
    #("DEFERRED", Deferred),
    #("DELETE", Delete),
    #("DESC", Desc),
    #("DETACH", Detach),
    #("DISTINCT", Distinct),
    #("DO", Do),
    #("DROP", Drop),
    #("EACH", Each),
    #("ELSE", Else),
    #("END", End),
    #("ESCAPE", Escape),
    #("EXCEPT", Except),
    #("EXCLUDE", Exclude),
    #("EXCLUSIVE", Exclusive),
    #("EXISTS", Exists),
    #("EXPLAIN", Explain),
    #("FAIL", Fail),
    #("FILTER", Filter),
    #("FIRST", First),
    #("FOLLOWING", Follwoing),
    #("FOR", For),
    #("FOREIGN", Foreign),
    #("FROM", From),
    #("FULL", Full),
    #("GENERATED", Generated),
    #("GLOB", Glob),
    #("GROUP", Group),
    #("GROUPS", Groups),
    #("HAVING", Having),
    #("IF", If),
    #("IGNORE", Ignore),
    #("IMMEDIATE", Immediate),
    #("IN", In),
    #("INDEX", Index),
    #("INDEXED", Indexed),
    #("INITIALLY", Initially),
    #("INNER", Inner),
    #("INSERT", Insert),
    #("INSTEAD", Instead),
    #("INTEGER", Integer),
    #("INTERSECT", Intersect),
    #("INTO", Into),
    #("IS", Is),
    #("ISNULL", Isnull),
    #("JOIN", Join),
    #("KEY", Key),
    #("LAST", Last),
    #("LEFT", Left),
    #("LIKE", Like),
    #("LIMIT", Limit),
    #("MATCH", Match),
    #("MATERIALIZED", Materialized),
    #("NATURAL", Natural),
    #("NO", No),
    #("NOT", Not),
    #("NOTHING", Nothing),
    #("NOTNULL", Notnull),
    #("NULL", Null),
    #("NULLS", Nulls),
    #("NUMERIC", Numeric),
    #("OF", Of),
    #("OFFSET", Offset),
    #("ON", On),
    #("OR", Or),
    #("ORDER", Order),
    #("OTHERS", Others),
    #("OUTER", Outer),
    #("OVER", Over),
    #("PARTITION", Partition),
    #("PLAN", Plan),
    #("PRAGMA", Pragma),
    #("PRECEDING", Precending),
    #("PRIMARY", Primary),
    #("QUERY", Query),
    #("RAISE", Raise),
    #("RANGE", Range),
    #("REAL", Real),
    #("RECURSIVE", Recursive),
    #("REFERENCES", References),
    #("REGEXP", Regexp),
    #("REINDEX", Reindex),
    #("RELEASE", Release),
    #("RENAME", Rename),
    #("REPLACE", Replace),
    #("RESTRICT", Restrict),
    #("RETURNING", Returning),
    #("RIGHT", Right),
    #("ROLLBACK", Rollback),
    #("ROW", Row),
    #("ROWS", Rows),
    #("SAVEPOINT", Savepoint),
    #("SELECT", Select),
    #("SET", Set),
    #("TABLE", Table),
    #("TEMP", Temp),
    #("TEMPORARY", Temporary),
    #("TEXT", Text),
    #("THEN", Then),
    #("TIES", Ties),
    #("TO", To),
    #("TRANSACTION", Transaction),
    #("TRIGGER", Trigger),
    #("UNBOUNDED", Unbounded),
    #("UNION", Union),
    #("UNIQUE", Unique),
    #("UPDATE", Update),
    #("USING", Using),
    #("VACUUM", Vacuum),
    #("VALUES", Values),
    #("VIEW", View),
    #("VIRTUAL", Virtual),
    #("WHEN", When),
    #("WHERE", Where),
    #("WINDOW", Window),
    #("WITH", With),
    #("WITHOUT", Without),
  ]
}

pub fn keyword_mathers(
  mapper: fn(String, Keyword) -> a,
) -> List(Matcher(a, mode)) {
  list.map(keywords(), fn(tuple) {
    let #(keyword, value) = tuple
    sql_keyword_matcher(keyword, value, mapper)
  })
}

pub fn stringify(keyword: Keyword) -> String {
  case keyword {
    Abort -> "ABORT"
    Action -> "ACTION"
    Add -> "ADD"
    After -> "AFTER"
    All -> "ALL"
    Alter -> "ALTER"
    Always -> "ALWAYS"
    Analyze -> "ANALYZE"
    And -> "AND"
    As -> "AS"
    Asc -> "ASC"
    Attach -> "ATTACH"
    Autoincrement -> "AUTOINCREMENT"
    Before -> "BEFORE"
    Begin -> "BEGIN"
    Between -> "BETWEEN"
    Blob -> "BLOB"
    By -> "BY"
    Cascade -> "CASCADE"
    Case -> "CASE"
    Cast -> "CAST"
    Check -> "CHECK"
    Collate -> "COLLATE"
    Column -> "COLUMN"
    Commit -> "COMMIT"
    Conflict -> "CONFLICT"
    Constraint -> "CONSTRAINT"
    Create -> "CREATE"
    Cross -> "CROSS"
    Current -> "CURRENT"
    CurrentDate -> "CURRENT_DATE"
    CurrentTime -> "CURRENT_TIME"
    CurrentTimestamp -> "CURRENT_TIMESTAMP"
    Database -> "DATABASE"
    Default -> "DEFAULT"
    Deferrable -> "DEFERRABLE"
    Deferred -> "DEFERRED"
    Delete -> "DELETE"
    Desc -> "DESC"
    Detach -> "DETACH"
    Distinct -> "DISTINCT"
    Do -> "DO"
    Drop -> "DROP"
    Each -> "EACH"
    Else -> "ELSE"
    End -> "END"
    Escape -> "ESCAPE"
    Except -> "EXCEPT"
    Exclude -> "EXCLUDE"
    Exclusive -> "EXCLUSIVE"
    Exists -> "EXISTS"
    Explain -> "EXPLAIN"
    Fail -> "FAIL"
    Filter -> "FILTER"
    First -> "FIRST"
    Follwoing -> "FOLLOWING"
    For -> "FOR"
    Foreign -> "FOREIGN"
    From -> "FROM"
    Full -> "FULL"
    Generated -> "GENERATED"
    Glob -> "GLOB"
    Group -> "GROUP"
    Groups -> "GROUPS"
    Having -> "HAVING"
    If -> "IF"
    Ignore -> "IGNORE"
    Immediate -> "IMMEDIATE"
    In -> "IN"
    Index -> "INDEX"
    Indexed -> "INDEXED"
    Initially -> "INITIALLY"
    Inner -> "INNER"
    Insert -> "INSERT"
    Instead -> "INSTEAD"
    Integer -> "INTEGER"
    Intersect -> "INTERSECT"
    Into -> "INTO"
    Is -> "IS"
    Isnull -> "ISNULL"
    Join -> "JOIN"
    Key -> "KEY"
    Last -> "LAST"
    Left -> "LEFT"
    Like -> "LIKE"
    Limit -> "LIMIT"
    Match -> "MATCH"
    Materialized -> "MATERIALIZED"
    Natural -> "NATURAL"
    No -> "NO"
    Not -> "NOT"
    Nothing -> "NOTHING"
    Notnull -> "NOTNULL"
    Null -> "NULL"
    Nulls -> "NULLS"
    Numeric -> "NUMERIC"
    Of -> "OF"
    Offset -> "OFFSET"
    On -> "ON"
    Or -> "OR"
    Order -> "ORDER"
    Others -> "OTHERS"
    Outer -> "OUTER"
    Over -> "OVER"
    Partition -> "PARTITION"
    Plan -> "PLAN"
    Pragma -> "PRAGMA"
    Precending -> "PRECEDING"
    Primary -> "PRIMARY"
    Query -> "QUERY"
    Raise -> "RAISE"
    Range -> "RANGE"
    Real -> "REAL"
    Recursive -> "RECURSIVE"
    References -> "REFERENCES"
    Regexp -> "REGEXP"
    Reindex -> "REINDEX"
    Release -> "RELEASE"
    Rename -> "RENAME"
    Replace -> "REPLACE"
    Restrict -> "RESTRICT"
    Returning -> "RETURNING"
    Right -> "RIGHT"
    Rollback -> "ROLLBACK"
    Row -> "ROW"
    Rows -> "ROWS"
    Savepoint -> "SAVEPOINT"
    Select -> "SELECT"
    Set -> "SET"
    Table -> "TABLE"
    Temp -> "TEMP"
    Temporary -> "TEMPORARY"
    Text -> "TEXT"
    Then -> "THEN"
    Ties -> "TIES"
    To -> "TO"
    Transaction -> "TRANSACTION"
    Trigger -> "TRIGGER"
    Unbounded -> "UNBOUNDED"
    Union -> "UNION"
    Unique -> "UNIQUE"
    Update -> "UPDATE"
    Using -> "USING"
    Vacuum -> "VACUUM"
    Values -> "VALUES"
    View -> "VIEW"
    Virtual -> "VIRTUAL"
    When -> "WHEN"
    Where -> "WHERE"
    Window -> "WINDOW"
    With -> "WITH"
    Without -> "WITHOUT"
  }
}

fn sql_keyword_matcher(
  keyword: String,
  value: Keyword,
  mapper: fn(String, Keyword) -> a,
) -> Matcher(a, mode) {
  let assert Ok(break) = regex.from_string(helper.breaker_regex)
  let keyword = string.uppercase(keyword)

  use mode, lexeme, lookahead <- lexer.custom
  let upper_lexeme = string.uppercase(lexeme)

  case
    upper_lexeme == keyword
    && { lookahead == "" || regex.check(break, lookahead) }
  {
    True -> Keep(mapper(lexeme, value), mode)
    False -> NoMatch
  }
}
