Lexer result:

Comment( Comments Inside Identifiers: Placing comments inside quoted identifiers is syntactically invalid but can cause the lexer to misinterpret where identifiers start and end.) | -- Comments Inside Identifiers: Placing comments inside quoted identifiers is syntactically invalid but can cause the lexer to misinterpret where identifiers start and end.
Whitespace(1) | 

Comment( Lexer Robustness: The lexer must properly handle or report errors when encountering such invalid constructs.) | -- Lexer Robustness: The lexer must properly handle or report errors when encountering such invalid constructs.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Comment( comment ) | /* comment */
Whitespace(0) |  
Identifier(my/*weird*/table) | "my/*weird*/table"
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
Identifier(my/*weird*/table) | "my/*weird*/table"
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(Test) | 'Test'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(my/*weird*/table) | "my/*weird*/table"
Special(;) | ;
Whitespace(1) | 

