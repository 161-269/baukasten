Lexer result:

Comment( Using subqueries and expressions in LIMIT and OFFSET.) | -- Using subqueries and expressions in LIMIT and OFFSET.
Whitespace(1) | 

Comment( Dynamic pagination based on table data.) | -- Dynamic pagination based on table data.
Whitespace(1) | 

Comment( Parser's handling of expressions in these clauses.) | -- Parser's handling of expressions in these clauses.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(limit_offset_test) | limit_offset_test
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
  
Identifier(id) | id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
  
Identifier(value) | value
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(limit_offset_test) | limit_offset_test
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(Row1) | 'Row1'
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
StringLiteral(Row2) | 'Row2'
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
StringLiteral(Row3) | 'Row3'
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
StringLiteral(Row4) | 'Row4'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(limit_offset_test) | limit_offset_test
Whitespace(0) |  
Keyword(LIMIT) | LIMIT
Whitespace(0) |  
Special(() | (
Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(COUNT) | COUNT
Special(() | (
Operator(*) | *
Special()) | )
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(limit_offset_test) | limit_offset_test
Special()) | )
Whitespace(0) |  
Operator(-) | -
Whitespace(0) |  
Numeric(2) | 2
Whitespace(0) |  
Keyword(OFFSET) | OFFSET
Whitespace(0) |  
Numeric(1) | 1
Special(;) | ;
Whitespace(1) | 

