Lexer result:

Comment( Subqueries within VALUES.) | -- Subqueries within VALUES.
Whitespace(1) | 

Comment( Use of built-in functions like AVG, ABS, and COALESCE.) | -- Use of built-in functions like AVG, ABS, and COALESCE.
Whitespace(1) | 

Comment( Nested parentheses and expressions.) | -- Nested parentheses and expressions.
Whitespace(1) | 

Comment( BETWEEN operator in WHERE clause.) | -- BETWEEN operator in WHERE clause.
Whitespace(3) | 



Comment( This is a single-line comment) | -- This is a single-line comment
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(test_table) | test_table
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
Whitespace(0) |  
Comment( Inline comment ) | /* Inline comment */
Whitespace(1) | 
  
Identifier(data) | data
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment(
This is a
multi-line comment
) | /*
This is a
multi-line comment
*/
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(test_table) | test_table
Whitespace(0) |  
Special(() | (
Identifier(id) | id
Special(,) | ,
Whitespace(0) |  
Identifier(data) | data
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
StringLiteral(Hello World) | 'Hello World'
Special()) | )
Special(;) | ;
Whitespace(0) |  
Comment( End-of-line comment) | -- End-of-line comment
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(test_table) | test_table
Whitespace(0) |  
Special(() | (
Identifier(id) | id
Special(,) | ,
Whitespace(0) |  
Identifier(data) | data
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(2) | 2
Special(,) | ,
Whitespace(0) |  
StringLiteral(It\') | 'It\'s
Whitespace(0) |  
Identifier(a) | a
Whitespace(0) |  
Identifier(sunny) | sunny
Whitespace(0) |  
Identifier(day') | day'
Special()) | )
Special(;) | ;
Whitespace(1) | 

