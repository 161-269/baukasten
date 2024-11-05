Lexer result:

Comment( Keywords as Identifiers: Using SQL keywords as table and column names can confuse the lexer if it does not differentiate between keywords and identifiers based on context.) | -- Keywords as Identifiers: Using SQL keywords as table and column names can confuse the lexer if it does not differentiate between keywords and identifiers based on context.
Whitespace(1) | 

Comment( Quoted Identifiers: The use of quotes around identifiers is essential here, and missing them can change the meaning entirely.) | -- Quoted Identifiers: The use of quotes around identifiers is essential here, and missing them can change the meaning entirely.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(select) | "select"
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(from) | "from"
Whitespace(0) |  
Keyword(TEXT) | TEXT
Special(,) | ,
Whitespace(1) | 
    
Identifier(where) | "where"
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
Identifier(select) | "select"
Whitespace(0) |  
Special(() | (
Identifier(from) | "from"
Special(,) | ,
Whitespace(0) |  
Identifier(where) | "where"
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(Data) | 'Data'
Special(,) | ,
Whitespace(0) |  
StringLiteral(More Data) | 'More Data'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(from) | "from"
Special(,) | ,
Whitespace(0) |  
Identifier(where) | "where"
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(select) | "select"
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(where) | "where"
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(More Data) | 'More Data'
Special(;) | ;
Whitespace(1) | 

