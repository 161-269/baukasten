Lexer result:

Comment( Reserved Words as Identifiers: Using words like constraint, check, foreign, which are reserved in certain contexts, can confuse the lexer if it doesn't handle them appropriately.) | -- Reserved Words as Identifiers: Using words like constraint, check, foreign, which are reserved in certain contexts, can confuse the lexer if it doesn't handle them appropriately.
Whitespace(1) | 

Comment( Contextual Keyword Recognition: The lexer must differentiate between reserved words used as identifiers and those used in their reserved context.) | -- Contextual Keyword Recognition: The lexer must differentiate between reserved words used as identifiers and those used in their reserved context.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(reserved_words) | reserved_words
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
    
Keyword(CONSTRAINT) | constraint
Whitespace(0) |  
Keyword(TEXT) | TEXT
Special(,) | ,
Whitespace(1) | 
    
Keyword(CHECK) | check
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
Identifier(reserved_words) | reserved_words
Whitespace(0) |  
Special(() | (
Keyword(CONSTRAINT) | constraint
Special(,) | ,
Whitespace(0) |  
Keyword(CHECK) | check
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(Test) | 'Test'
Special(,) | ,
Whitespace(0) |  
Numeric(1) | 1
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(ALTER) | ALTER
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(reserved_words) | reserved_words
Whitespace(0) |  
Keyword(ADD) | ADD
Whitespace(0) |  
Keyword(COLUMN) | COLUMN
Whitespace(0) |  
Keyword(FOREIGN) | foreign
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Keyword(CONSTRAINT) | constraint
Special(,) | ,
Whitespace(0) |  
Keyword(CHECK) | check
Special(,) | ,
Whitespace(0) |  
Keyword(FOREIGN) | foreign
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(reserved_words) | reserved_words
Special(;) | ;
Whitespace(1) | 

