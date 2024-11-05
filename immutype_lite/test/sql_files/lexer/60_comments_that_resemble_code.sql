Lexer result:

Comment( Code in Comments: Comments containing code that could be misinterpreted as active code can confuse lexers that do not properly skip over comments.) | -- Code in Comments: Comments containing code that could be misinterpreted as active code can confuse lexers that do not properly skip over comments.
Whitespace(1) | 

Comment( Security Considerations: Ensuring that the lexer correctly ignores commented-out code is crucial to prevent unintended execution.) | -- Security Considerations: Ensuring that the lexer correctly ignores commented-out code is crucial to prevent unintended execution.
Whitespace(3) | 



Comment( SELECT * FROM users WHERE username = 'admin'; DROP TABLE users; --) | -- SELECT * FROM users WHERE username = 'admin'; DROP TABLE users; --
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(safe_table) | safe_table
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
    
Identifier(data) | data
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
Identifier(safe_table) | safe_table
Whitespace(0) |  
Special(() | (
Identifier(data) | data
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(All good here) | 'All good here'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Special(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(safe_table) | safe_table
Special(;) | ;
Whitespace(1) | 

