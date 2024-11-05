Lexer result:

Comment( Table and column names containing quotes and special characters.) | -- Table and column names containing quotes and special characters.
Whitespace(1) | 

Comment( Escaped quotes within identifiers and string literals.) | -- Escaped quotes within identifiers and string literals.
Whitespace(1) | 

Comment( Mixing single and double quotes.) | -- Mixing single and double quotes.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(weird'table) | "weird'table"
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
  
Identifier(odd\"column) | "odd\"column"
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
Identifier(weird'table) | "weird'table"
Whitespace(0) |  
Special(() | (
Identifier(odd\"column) | "odd\"column"
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(Value with ''single'' and "double" quotes) | 'Value with ''single'' and "double" quotes'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(odd\"column) | "odd\"column"
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(weird'table) | "weird'table"
Special(;) | ;
Whitespace(1) | 

