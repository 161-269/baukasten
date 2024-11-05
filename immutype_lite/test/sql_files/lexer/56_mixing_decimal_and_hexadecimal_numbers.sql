Lexer result:

Comment( Number Formats: SQLite does not support hexadecimal (0x) or octal (0) number literals. Including them can cause lexers to misinterpret number tokens.) | -- Number Formats: SQLite does not support hexadecimal (0x) or octal (0) number literals. Including them can cause lexers to misinterpret number tokens.
Whitespace(1) | 

Comment( Lexer Number Parsing: The lexer must correctly tokenize numbers and handle unsupported formats appropriately.) | -- Lexer Number Parsing: The lexer must correctly tokenize numbers and handle unsupported formats appropriately.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(number_test) | number_test
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
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(number_test) | number_test
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(10) | 10
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Identifier(0x0A) | 0x0A
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Identifier(012) | 012
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(number_test) | number_test
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(10) | 10
Special(;) | ;
Whitespace(1) | 

