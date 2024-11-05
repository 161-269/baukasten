Lexer result:

Comment( Invalid Delimiters: Using square brackets [ ] as identifier delimiters is common in some SQL dialects but not valid in SQLite.) | -- Invalid Delimiters: Using square brackets [ ] as identifier delimiters is common in some SQL dialects but not valid in SQLite.
Whitespace(1) | 

Comment( Alternate Delimiters: Backticks ` are allowed in SQLite for compatibility but may not be expected.) | -- Alternate Delimiters: Backticks ` are allowed in SQLite for compatibility but may not be expected.
Whitespace(1) | 

Comment( Lexer Flexibility: The lexer must handle or properly reject invalid syntax while accepting valid alternate delimiters.) | -- Lexer Flexibility: The lexer must handle or properly reject invalid syntax while accepting valid alternate delimiters.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(mix_delim) | mix_delim
Whitespace(0) |  
Identifier(id INTEGER) | [id INTEGER]
Special(;) | ;
Whitespace(0) |  
Comment( Using square brackets (invalid in SQLite)) | -- Using square brackets (invalid in SQLite)
Whitespace(2) | 


Comment( However, SQLite supports using backticks for identifiers) | -- However, SQLite supports using backticks for identifiers
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(backtick_table) | `backtick_table`
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(key) | `key`
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
    
Identifier(value) | `value`
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
Identifier(backtick_table) | `backtick_table`
Whitespace(0) |  
Special(() | (
Identifier(key) | `key`
Special(,) | ,
Whitespace(0) |  
Identifier(value) | `value`
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Numeric(1) | 1
Special(,) | ,
Whitespace(0) |  
StringLiteral(Data) | 'Data'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(value) | `value`
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(backtick_table) | `backtick_table`
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(key) | `key`
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Numeric(1) | 1
Special(;) | ;
Whitespace(1) | 

