Lexer result:

Comment( Overriding default collation in WHERE clause.) | -- Overriding default collation in WHERE clause.
Whitespace(1) | 

Comment( Mixing different collations in queries.) | -- Mixing different collations in queries.
Whitespace(1) | 

Comment( Parser's handling of collation precedence.) | -- Parser's handling of collation precedence.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(collate_override) | collate_override
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
  
Identifier(value) | value
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(COLLATE) | COLLATE
Whitespace(0) |  
Identifier(BINARY) | BINARY
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(collate_override) | collate_override
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(apple) | 'apple'
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
StringLiteral(Apple) | 'Apple'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(collate_override) | collate_override
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(APPLE) | 'APPLE'
Whitespace(0) |  
Keyword(COLLATE) | COLLATE
Whitespace(0) |  
Identifier(NOCASE) | NOCASE
Special(;) | ;
Whitespace(1) | 

