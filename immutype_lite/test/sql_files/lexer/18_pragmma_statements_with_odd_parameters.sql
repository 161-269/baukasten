Lexer result:

Comment( Setting unusual PRAGMA parameters (negative cache size).) | -- Setting unusual PRAGMA parameters (negative cache size).
Whitespace(1) | 

Comment( Changing database encoding to UTF-16 little endian.) | -- Changing database encoding to UTF-16 little endian.
Whitespace(1) | 

Comment( Parser's handling of PRAGMA statements with various parameters.) | -- Parser's handling of PRAGMA statements with various parameters.
Whitespace(3) | 



Keyword(PRAGMA) | PRAGMA
Whitespace(0) |  
Identifier(page_size) | page_size
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(1024) | 1024
Special(;) | ;
Whitespace(1) | 

Keyword(PRAGMA) | PRAGMA
Whitespace(0) |  
Identifier(cache_size) | cache_size
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Operator(-) | -
Identifier(2000) | 2000
Special(;) | ;
Whitespace(1) | 

Keyword(PRAGMA) | PRAGMA
Whitespace(0) |  
Identifier(encoding) | encoding
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(UTF-16le) | 'UTF-16le'
Special(;) | ;
Whitespace(2) | 


Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(pragma_test) | pragma_test
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
Identifier(pragma_test) | pragma_test
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(Test Encoding) | 'Test Encoding'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(pragma_test) | pragma_test
Special(;) | ;
Whitespace(1) | 

