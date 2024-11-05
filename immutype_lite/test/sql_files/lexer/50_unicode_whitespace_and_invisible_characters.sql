Lexer result:

Comment( Unicode Whitespace: The code uses Unicode non-breaking spaces and other whitespace characters that are visually similar to regular spaces but have different code points.) | -- Unicode Whitespace: The code uses Unicode non-breaking spaces and other whitespace characters that are visually similar to regular spaces but have different code points.
Whitespace(1) | 

Comment( Token Separation Issues: Lexers that rely on specific ASCII whitespace characters may fail to properly tokenize input containing Unicode whitespace.) | -- Token Separation Issues: Lexers that rely on specific ASCII whitespace characters may fail to properly tokenize input containing Unicode whitespace.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(unicode_whitespace) | unicode_whitespace
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
Identifier(unicode_whitespace) | unicode_whitespace
Special(() | (
Identifier(id) | id
Special(,) | ,
Whitespace(0) |  
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
StringLiteral(Data with unicode spaces) | 'Data with unicode spaces'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Special(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(unicode_whitespace) | unicode_whitespace
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(id=1) | id=1
Special(;) | ;
Whitespace(1) | 

