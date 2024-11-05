Lexer result:

Comment( Invalid Escape Sequences: \z is not a valid escape sequence in SQLite. Lexers must handle invalid escapes properly.) | -- Invalid Escape Sequences: \z is not a valid escape sequence in SQLite. Lexers must handle invalid escapes properly.
Whitespace(1) | 

Comment( String Parsing: The lexer must not crash or behave unexpectedly when encountering malformed escapes.) | -- String Parsing: The lexer must not crash or behave unexpectedly when encountering malformed escapes.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(escape_test) | escape_test
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
Identifier(escape_test) | escape_test
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(This is a test\z) | 'This is a test\z'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(escape_test) | escape_test
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Keyword(LIKE) | LIKE
Whitespace(0) |  
StringLiteral(This%) | 'This%'
Special(;) | ;
Whitespace(1) | 

