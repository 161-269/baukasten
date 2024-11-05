Lexer result:

Comment( Circular References: Expressions that reference the same table and column in complex ways can challenge the lexer and parser in maintaining context.) | -- Circular References: Expressions that reference the same table and column in complex ways can challenge the lexer and parser in maintaining context.
Whitespace(1) | 

Comment( Nested Queries: The lexer must correctly tokenize nested queries within expressions.) | -- Nested Queries: The lexer must correctly tokenize nested queries within expressions.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(self_ref) | self_ref
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
Identifier(self_ref) | self_ref
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Numeric(1) | 1
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(UPDATE) | UPDATE
Whitespace(0) |  
Identifier(self_ref) | self_ref
Whitespace(0) |  
Keyword(SET) | SET
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Special(() | (
Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(self_ref) | self_ref
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(id) | id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(value) | value
Special()) | )
Special(;) | ;
Whitespace(1) | 

