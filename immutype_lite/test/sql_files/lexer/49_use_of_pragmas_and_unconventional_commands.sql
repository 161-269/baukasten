Lexer result:

Comment( PRAGMA in Expressions: Using PRAGMA statements within expressions or SELECT statements is not standard and can confuse the lexer.) | -- PRAGMA in Expressions: Using PRAGMA statements within expressions or SELECT statements is not standard and can confuse the lexer.
Whitespace(1) | 

Comment( Command Context: The lexer must recognize that PRAGMA is a standalone command and not a function or expression.) | -- Command Context: The lexer must recognize that PRAGMA is a standalone command and not a function or expression.
Whitespace(3) | 



Keyword(PRAGMA) | PRAGMA
Whitespace(0) |  
Identifier(recursive_triggers) | recursive_triggers
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(on) | 'on'
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


Comment( Use a PRAGMA as part of an expression (not standard)) | -- Use a PRAGMA as part of an expression (not standard)
Whitespace(1) | 

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
StringLiteral(Test ) | 'Test '
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
Keyword(PRAGMA) | PRAGMA
Whitespace(0) |  
Identifier(user_version) | user_version
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Setting a PRAGMA in an unusual place) | -- Setting a PRAGMA in an unusual place
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(pragma_test) | pragma_test
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(id) | id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Special(() | (
Keyword(PRAGMA) | PRAGMA
Whitespace(0) |  
Identifier(page_count) | page_count
Special()) | )
Special(;) | ;
Whitespace(1) | 

