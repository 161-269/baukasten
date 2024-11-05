Lexer result:

Comment( Using reserved keywords (select, from, where) as table and column names without quotes.) | -- Using reserved keywords (select, from, where) as table and column names without quotes.
Whitespace(1) | 

Comment( No syntax errors due to SQLite's permissiveness with identifiers.) | -- No syntax errors due to SQLite's permissiveness with identifiers.
Whitespace(1) | 

Comment( Potential confusion in parsing due to overlap with SQL keywords.) | -- Potential confusion in parsing due to overlap with SQL keywords.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Keyword(SELECT) | select
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
  
Keyword(FROM) | from
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Special(,) | ,
Whitespace(1) | 
  
Keyword(WHERE) | where
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
Keyword(SELECT) | select
Special(() | (
Keyword(FROM) | from
Special(,) | ,
Whitespace(0) |  
Keyword(WHERE) | where
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
StringLiteral(Test) | 'Test'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Keyword(SELECT) | select
Special(.) | .
Keyword(FROM) | from
Special(,) | ,
Whitespace(0) |  
Keyword(SELECT) | select
Special(.) | .
Keyword(WHERE) | where
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Keyword(SELECT) | select
Special(;) | ;
Whitespace(1) | 

