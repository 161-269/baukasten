Lexer result:

Comment( Very long table and column names.) | -- Very long table and column names.
Whitespace(1) | 

Comment( Extremely long string literals.) | -- Extremely long string literals.
Whitespace(1) | 

Comment( Testing parser limits for identifier and literal lengths.) | -- Testing parser limits for identifier and literal lengths.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(this_is_an_extremely_long_table_name_that_should_still_be_valid_in_sql_but_is_unnecessarily_verbose) | "this_is_an_extremely_long_table_name_that_should_still_be_valid_in_sql_but_is_unnecessarily_verbose"
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
  
Identifier(this_is_an_extremely_long_column_name_that_tests_the_parser_limits) | "this_is_an_extremely_long_column_name_that_tests_the_parser_limits"
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
Identifier(this_is_an_extremely_long_table_name_that_should_still_be_valid_in_sql_but_is_unnecessarily_verbose) | "this_is_an_extremely_long_table_name_that_should_still_be_valid_in_sql_but_is_unnecessarily_verbose"
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
  
Identifier(this_is_an_extremely_long_column_name_that_tests_the_parser_limits) | "this_is_an_extremely_long_column_name_that_tests_the_parser_limits"
Whitespace(1) | 

Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(This is a very long string literal that is used to test the parser''s ability to handle large amounts of text in a single statement without breaking.) | 'This is a very long string literal that is used to test the parser''s ability to handle large amounts of text in a single statement without breaking.'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(this_is_an_extremely_long_table_name_that_should_still_be_valid_in_sql_but_is_unnecessarily_verbose) | "this_is_an_extremely_long_table_name_that_should_still_be_valid_in_sql_but_is_unnecessarily_verbose"
Special(;) | ;
Whitespace(1) | 

