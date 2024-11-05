Lexer result:

Comment( Defining generated (computed) columns.) | -- Defining generated (computed) columns.
Whitespace(1) | 

Comment( Using expressions in column definitions.) | -- Using expressions in column definitions.
Whitespace(1) | 

Comment( Parser's ability to handle GENERATED ALWAYS AS syntax.) | -- Parser's ability to handle GENERATED ALWAYS AS syntax.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(generated_columns) | generated_columns
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
  
Identifier(base_value) | base_value
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Special(,) | ,
Whitespace(1) | 
  
Identifier(doubled_value) | doubled_value
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(GENERATED) | GENERATED
Whitespace(0) |  
Keyword(ALWAYS) | ALWAYS
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Special(() | (
Identifier(base_value) | base_value
Whitespace(0) |  
Special(*) | *
Whitespace(0) |  
Identifier(2) | 2
Special()) | )
Whitespace(0) |  
Identifier(STORED) | STORED
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(generated_columns) | generated_columns
Whitespace(0) |  
Special(() | (
Identifier(base_value) | base_value
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
Identifier(20) | 20
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Special(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(generated_columns) | generated_columns
Special(;) | ;
Whitespace(1) | 

