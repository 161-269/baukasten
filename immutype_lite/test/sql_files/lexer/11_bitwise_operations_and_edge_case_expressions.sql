Lexer result:

Comment( Use of bitwise operators (|, &, ~, <<) in expressions.) | -- Use of bitwise operators (|, &, ~, <<) in expressions.
Whitespace(1) | 

Comment( Bitwise operations in INSERT and WHERE clauses.) | -- Bitwise operations in INSERT and WHERE clauses.
Whitespace(1) | 

Comment( Testing parser's handling of bitwise syntax and precedence.) | -- Testing parser's handling of bitwise syntax and precedence.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(bitwise_test) | bitwise_test
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
  
Identifier(flags) | flags
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
Identifier(bitwise_test) | bitwise_test
Whitespace(0) |  
Special(() | (
Identifier(id) | id
Special(,) | ,
Whitespace(0) |  
Identifier(flags) | flags
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 

Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
Identifier(0) | 0
Whitespace(0) |  
Operator(|) | |
Whitespace(0) |  
Identifier(1) | 1
Special()) | )
Special(,) | ,
Whitespace(1) | 

Special(() | (
Identifier(2) | 2
Special(,) | ,
Whitespace(0) |  
Identifier(1) | 1
Whitespace(0) |  
Operator(<<) | <<
Whitespace(0) |  
Identifier(2) | 2
Special()) | )
Special(,) | ,
Whitespace(1) | 

Special(() | (
Identifier(3) | 3
Special(,) | ,
Whitespace(0) |  
Operator(~) | ~
Identifier(0) | 0
Whitespace(0) |  
Operator(&) | &
Whitespace(0) |  
Identifier(255) | 255
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(id) | id
Special(,) | ,
Whitespace(0) |  
Identifier(flags) | flags
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(bitwise_test) | bitwise_test
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(flags) | flags
Whitespace(0) |  
Operator(&) | &
Whitespace(0) |  
Identifier(2) | 2
Special(;) | ;
Whitespace(1) | 

