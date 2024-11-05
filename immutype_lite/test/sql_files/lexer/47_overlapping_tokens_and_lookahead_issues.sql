Lexer result:

Comment( No Spaces Between Tokens: The SELECTvalue FROMlookahead_testWHEREid=1; line intentionally omits spaces between tokens.) | -- No Spaces Between Tokens: The SELECTvalue FROMlookahead_testWHEREid=1; line intentionally omits spaces between tokens.
Whitespace(1) | 

Comment( Token Boundary Detection: The lexer must correctly identify where one token ends and the next begins without relying on whitespace.) | -- Token Boundary Detection: The lexer must correctly identify where one token ends and the next begins without relying on whitespace.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(lookahead_test) | lookahead_test
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
Identifier(lookahead_test) | lookahead_test
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
StringLiteral(Test) | 'Test'
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Numeric(2) | 2
Special(,) | ,
Whitespace(0) |  
StringLiteral(Another Test) | 'Another Test'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Identifier(SELECTvalue) | SELECTvalue
Whitespace(0) |  
Identifier(FROMlookahead_testWHEREid) | FROMlookahead_testWHEREid
Operator(=) | =
Numeric(1) | 1
Special(;) | ;
Whitespace(1) | 

