Lexer result:

Comment( Non-standard comments (e.g., /*- ... -*/).) | -- Non-standard comments (e.g., /*- ... -*/).
Whitespace(1) | 

Comment( Use of optimizer hints syntax (ignored in SQLite).) | -- Use of optimizer hints syntax (ignored in SQLite).
Whitespace(1) | 

Comment( Shell-style comments (# ...) within SQL scripts.) | -- Shell-style comments (# ...) within SQL scripts.
Whitespace(1) | 

Comment( Parser's ability to handle and ignore unconventional comments.) | -- Parser's ability to handle and ignore unconventional comments.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(comment_test) | comment_test
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


Comment(- Custom comment style that might confuse the parser -) | /*- Custom comment style that might confuse the parser -*/
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Comment(+ optimizer_hint ) | /*+ optimizer_hint */
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(comment_test) | comment_test
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(Test Value) | 'Test Value'
Special()) | )
Special(;) | ;
Whitespace(0) |  
Comment( Shell-style comment) | # Shell-style comment
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Special(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(comment_test) | comment_test
Special(;) | ;
Whitespace(1) | 

