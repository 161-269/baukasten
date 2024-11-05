Lexer result:

Comment( Chained Operators: Using operators like >>> and <<< (which are not standard in SQLite) without spaces can confuse the lexer.) | -- Chained Operators: Using operators like >>> and <<< (which are not standard in SQLite) without spaces can confuse the lexer.
Whitespace(1) | 

Comment( Operator Recognition: The lexer must correctly tokenize operators and not misinterpret >> followed by > as a single >>> operator.) | -- Operator Recognition: The lexer must correctly tokenize operators and not misinterpret >> followed by > as a single >>> operator.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(operator_test) | operator_test
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
Keyword(INTEGER) | INTEGER
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(operator_test) | operator_test
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(1) | 1
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Identifier(2) | 2
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Identifier(3) | 3
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(operator_test) | operator_test
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(value>>>1) | value>>>1
Special(;) | ;
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(operator_test) | operator_test
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(value<<<=2) | value<<<=2
Special(;) | ;
Whitespace(1) | 

