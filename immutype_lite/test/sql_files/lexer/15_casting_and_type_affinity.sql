Lexer result:

Comment( Casting strings to different numeric types.) | -- Casting strings to different numeric types.
Whitespace(1) | 

Comment( Mixing integer and real numbers in calculations.) | -- Mixing integer and real numbers in calculations.
Whitespace(1) | 

Comment( Testing type affinity and conversion behaviors.) | -- Testing type affinity and conversion behaviors.
Whitespace(3) | 



Keyword(SELECT) | SELECT
Whitespace(0) |  
Keyword(CAST) | CAST
Special(() | (
StringLiteral(123) | '123'
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Special()) | )
Whitespace(0) |  
Operator(+) | +
Whitespace(0) |  
Keyword(CAST) | CAST
Special(() | (
StringLiteral(456.789) | '456.789'
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Keyword(REAL) | REAL
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(result) | result
Special(;) | ;
Whitespace(1) | 

