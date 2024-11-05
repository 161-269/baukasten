Lexer result:

Comment( Unsupported Preprocessor Directives: SQLite does not support macros like #define. Including them can confuse the lexer if it attempts to process these directives.) | -- Unsupported Preprocessor Directives: SQLite does not support macros like #define. Including them can confuse the lexer if it attempts to process these directives.
Whitespace(1) | 

Comment( Lexer Expectations: The lexer must recognize that these directives are not part of SQLite syntax and handle or report them appropriately.) | -- Lexer Expectations: The lexer must recognize that these directives are not part of SQLite syntax and handle or report them appropriately.
Whitespace(3) | 



Comment( Attempting to use macros or variable substitution) | -- Attempting to use macros or variable substitution
Whitespace(1) | 

MacroDefinition(MAX_VALUE -> 100) | #define MAX_VALUE 100
Whitespace(2) | 


Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(macro_test) | macro_test
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
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(CHECK) | CHECK
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Whitespace(0) |  
Operator(<=) | <=
Whitespace(0) |  
Identifier(MAX_VALUE) | MAX_VALUE
Special()) | )
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(macro_test) | macro_test
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(50) | 50
Special()) | )
Special(;) | ;
Whitespace(1) | 

