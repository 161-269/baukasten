Lexer result:

Comment( Multiple statements on a single line.) | -- Multiple statements on a single line.
Whitespace(1) | 

Comment( Lack of line breaks between statements.) | -- Lack of line breaks between statements.
Whitespace(1) | 

Comment( Testing parser's ability to correctly separate and parse multiple statements.) | -- Testing parser's ability to correctly separate and parse multiple statements.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(multi_stmt) | multi_stmt
Special(() | (
Identifier(id) | id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special()) | )
Special(;) | ;
Whitespace(0) |  
Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(multi_stmt) | multi_stmt
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(1) | 1
Special()) | )
Special(;) | ;
Whitespace(0) |  
Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(multi_stmt) | multi_stmt
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(2) | 2
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Special(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(multi_stmt) | multi_stmt
Special(;) | ;
Whitespace(0) |  
Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(COUNT) | COUNT
Special(() | (
Special(*) | *
Special()) | )
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(multi_stmt) | multi_stmt
Special(;) | ;
Whitespace(1) | 

