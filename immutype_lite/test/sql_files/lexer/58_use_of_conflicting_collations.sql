Lexer result:

Comment( Multiple Collations: Applying multiple COLLATE clauses can confuse the lexer or parser if it doesn't expect them.) | -- Multiple Collations: Applying multiple COLLATE clauses can confuse the lexer or parser if it doesn't expect them.
Whitespace(1) | 

Comment( Conflict Resolution: The lexer must tokenize collations correctly and the parser must resolve which collation applies.) | -- Conflict Resolution: The lexer must tokenize collations correctly and the parser must resolve which collation applies.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(collation_test) | collation_test
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(value) | value
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(COLLATE) | COLLATE
Whitespace(0) |  
Identifier(NOCASE) | NOCASE
Whitespace(0) |  
Keyword(COLLATE) | COLLATE
Whitespace(0) |  
Identifier(BINARY) | BINARY
Whitespace(0) |  
Keyword(COLLATE) | COLLATE
Whitespace(0) |  
Identifier(RTRIM) | RTRIM
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(collation_test) | collation_test
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral( Test ) | ' Test '
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Special(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(collation_test) | collation_test
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(test) | 'test'
Special(;) | ;
Whitespace(1) | 

