Lexer result:

Comment( Unicode Identifiers: Using emojis or other Unicode characters in table and column names can break lexers that assume identifiers are ASCII-only.) | -- Unicode Identifiers: Using emojis or other Unicode characters in table and column names can break lexers that assume identifiers are ASCII-only.
Whitespace(1) | 

Comment( Character Encoding Issues: If the lexer does not handle Unicode correctly, it may misinterpret or fail to tokenize these identifiers.) | -- Character Encoding Issues: If the lexer does not handle Unicode correctly, it may misinterpret or fail to tokenize these identifiers.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(😀) | 😀
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(😂) | 😂
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
Identifier(😀) | 😀
Whitespace(0) |  
Special(() | (
Identifier(😂) | 😂
Special(,) | ,
Whitespace(0) |  
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
StringLiteral(Emojis as identifiers) | 'Emojis as identifiers'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(😀) | 😀
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(😂) | 😂
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(1) | 1
Special(;) | ;
Whitespace(1) | 

