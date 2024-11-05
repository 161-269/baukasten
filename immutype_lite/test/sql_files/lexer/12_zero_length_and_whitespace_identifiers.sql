Lexer result:

Comment( Empty string ("") and whitespace (" ") as table and column names.) | -- Empty string ("") and whitespace (" ") as table and column names.
Whitespace(1) | 

Comment( Quotes used to create zero-length identifiers.) | -- Quotes used to create zero-length identifiers.
Whitespace(1) | 

Comment( Parsing challenges with ambiguous or empty identifiers.) | -- Parsing challenges with ambiguous or empty identifiers.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier() | ""
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
  
Identifier() | ""
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
  
Identifier( ) | " "
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
Identifier() | ""
Whitespace(0) |  
Special(() | (
Whitespace(0) |  
Identifier() | ""
Special(,) | ,
Whitespace(0) |  
Identifier( ) | " "
Whitespace(0) |  
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
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
Identifier( ) | " "
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier() | ""
Special(;) | ;
Whitespace(1) | 

