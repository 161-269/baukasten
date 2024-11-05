Lexer result:

Comment( Type Ambiguity: The column a contains both integer and string representations of the number one.) | -- Type Ambiguity: The column a contains both integer and string representations of the number one.
Whitespace(1) | 

Comment( Token Type Differentiation: Lexers may struggle if they attempt to infer types during tokenization rather than deferring to parsing or execution stages.) | -- Token Type Differentiation: Lexers may struggle if they attempt to infer types during tokenization rather than deferring to parsing or execution stages.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(ambiguity_test) | ambiguity_test
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(1) | 1
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(a) | a
Whitespace(0) |  
Keyword(UNION) | UNION
Whitespace(0) |  
Keyword(SELECT) | SELECT
Whitespace(0) |  
StringLiteral(1) | '1'
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(ambiguity_test) | ambiguity_test
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(a) | a
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(1) | 1
Special(;) | ;
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(ambiguity_test) | ambiguity_test
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(a) | a
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(1) | '1'
Special(;) | ;
Whitespace(1) | 

