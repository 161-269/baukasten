Lexer result:

Comment( Specifying different collation sequences in ORDER BY.) | -- Specifying different collation sequences in ORDER BY.
Whitespace(1) | 

Comment( Overriding column collation in queries.) | -- Overriding column collation in queries.
Whitespace(1) | 

Comment( Parser handling of collation specifications.) | -- Parser handling of collation specifications.
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
StringLiteral(a) | 'a'
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
StringLiteral(A) | 'A'
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
Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Keyword(COLLATE) | COLLATE
Whitespace(0) |  
Identifier(RTRIM) | RTRIM
Special(;) | ;
Whitespace(1) | 

