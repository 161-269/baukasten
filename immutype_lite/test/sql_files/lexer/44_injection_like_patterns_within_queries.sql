Lexer result:

Comment( Quotes Within Strings: The password field contains quotes that can confuse string literal parsing.) | -- Quotes Within Strings: The password field contains quotes that can confuse string literal parsing.
Whitespace(1) | 

Comment( Comment Indicators Inside Strings: The use of -- within a string may trick the lexer into interpreting the rest of the line as a comment.) | -- Comment Indicators Inside Strings: The use of -- within a string may trick the lexer into interpreting the rest of the line as a comment.
Whitespace(1) | 

Comment( SQL Injection Patterns: While not executing injection, the patterns mimic injection techniques, testing the lexer's ability to distinguish between code and data.) | -- SQL Injection Patterns: While not executing injection, the patterns mimic injection techniques, testing the lexer's ability to distinguish between code and data.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(users) | users
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
    
Identifier(username) | username
Whitespace(0) |  
Keyword(TEXT) | TEXT
Special(,) | ,
Whitespace(1) | 
    
Identifier(password) | password
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
Identifier(users) | users
Whitespace(0) |  
Special(() | (
Identifier(username) | username
Special(,) | ,
Whitespace(0) |  
Identifier(password) | password
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
StringLiteral(admin) | 'admin'
Special(,) | ,
Whitespace(0) |  
StringLiteral('' OR 1=1 --) | ''' OR 1=1 --'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(user) | 'user'
Special(,) | ,
Whitespace(0) |  
StringLiteral(password) | 'password'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Special(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(users) | users
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(username) | username
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(admin) | 'admin'
Whitespace(0) |  
Keyword(AND) | AND
Whitespace(0) |  
Identifier(password) | password
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral('' OR 1=1 --) | ''' OR 1=1 --'
Special(;) | ;
Whitespace(1) | 

