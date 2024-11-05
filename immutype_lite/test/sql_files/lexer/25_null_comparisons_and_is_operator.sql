Lexer result:

Comment( Difference between IS NULL and = NULL.) | -- Difference between IS NULL and = NULL.
Whitespace(1) | 

Comment( Understanding SQLite's handling of NULL comparisons.) | -- Understanding SQLite's handling of NULL comparisons.
Whitespace(1) | 

Comment( Parser's interpretation of NULL in expressions.) | -- Parser's interpretation of NULL in expressions.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(null_test) | null_test
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
  
Identifier(id) | id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
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
Identifier(null_test) | null_test
Whitespace(0) |  
Special(() | (
Identifier(id) | id
Special(,) | ,
Whitespace(0) |  
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Numeric(1) | 1
Special(,) | ,
Whitespace(0) |  
Keyword(NULL) | NULL
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Numeric(2) | 2
Special(,) | ,
Whitespace(0) |  
StringLiteral(Not Null) | 'Not Null'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(null_test) | null_test
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Keyword(IS) | IS
Whitespace(0) |  
Keyword(NULL) | NULL
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(null_test) | null_test
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Keyword(NULL) | NULL
Special(;) | ;
Whitespace(1) | 

