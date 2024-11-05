Lexer result:

Comment( Unescaped Single Quotes: The string O'Reilly contains an unescaped single quote, which can prematurely terminate the string literal.) | -- Unescaped Single Quotes: The string O'Reilly contains an unescaped single quote, which can prematurely terminate the string literal.
Whitespace(1) | 

Comment( String Boundary Detection: The lexer must handle escaped quotes or double up single quotes ('O''Reilly') to correctly parse the string.) | -- String Boundary Detection: The lexer must handle escaped quotes or double up single quotes ('O''Reilly') to correctly parse the string.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(test) | test
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
Identifier(test) | test
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(O'Reilly) | 'O'Reilly'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Special(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(test) | test
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(O'Reilly) | 'O'Reilly'
Special(;) | ;
Whitespace(1) | 

