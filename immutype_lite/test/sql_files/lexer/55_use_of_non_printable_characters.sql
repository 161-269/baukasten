Lexer result:

Comment( Control Characters in Strings: Including non-printable control characters can disrupt lexers that are not designed to handle them.) | -- Control Characters in Strings: Including non-printable control characters can disrupt lexers that are not designed to handle them.
Whitespace(1) | 

Comment( Character Encoding and Representation: The lexer must correctly process and represent these characters internally.) | -- Character Encoding and Representation: The lexer must correctly process and represent these characters internally.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(non_printable) | non_printable
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
Identifier(non_printable) | non_printable
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(Data with control character \x01 in it) | 'Data with control character \x01 in it'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Special(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(non_printable) | non_printable
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Keyword(LIKE) | LIKE
Whitespace(0) |  
StringLiteral(%\x01%) | '%\x01%'
Special(;) | ;
Whitespace(1) | 

