Lexer result:

Comment( Using window functions (SUM() OVER). -- ) | -- Using window functions (SUM() OVER). -- 
Whitespace(1) | 

Comment( Using window functions (SUM() OVER). -- PARTITION BY and ORDER BY within window functions.) | -- Using window functions (SUM() OVER). -- PARTITION BY and ORDER BY within window functions.
Whitespace(1) | 

Comment( Using window functions (SUM() OVER). -- Parser's support for advanced analytical functions.) | -- Using window functions (SUM() OVER). -- Parser's support for advanced analytical functions.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(sales) | sales
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
  
Identifier(salesperson) | salesperson
Whitespace(0) |  
Keyword(TEXT) | TEXT
Special(,) | ,
Whitespace(1) | 
  
Identifier(amount) | amount
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(sales) | sales
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(Alice) | 'Alice'
Special(,) | ,
Whitespace(0) |  
Identifier(500) | 500
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
StringLiteral(Bob) | 'Bob'
Special(,) | ,
Whitespace(0) |  
Identifier(700) | 700
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
StringLiteral(Alice) | 'Alice'
Special(,) | ,
Whitespace(0) |  
Identifier(300) | 300
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
StringLiteral(Bob) | 'Bob'
Special(,) | ,
Whitespace(0) |  
Identifier(400) | 400
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(1) | 
  
Identifier(salesperson) | salesperson
Special(,) | ,
Whitespace(1) | 
  
Identifier(amount) | amount
Special(,) | ,
Whitespace(1) | 
  
Identifier(SUM) | SUM
Special(() | (
Identifier(amount) | amount
Special()) | )
Whitespace(0) |  
Keyword(OVER) | OVER
Whitespace(0) |  
Special(() | (
Keyword(PARTITION) | PARTITION
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(0) |  
Identifier(salesperson) | salesperson
Whitespace(0) |  
Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(0) |  
Identifier(amount) | amount
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(cumulative_total) | cumulative_total
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(sales) | sales
Special(;) | ;
Whitespace(1) | 

