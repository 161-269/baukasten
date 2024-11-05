Lexer result:

Comment( Excessive Nesting: Deeply nested parentheses can cause stack overflows or performance issues in lexers that use recursive descent parsing.) | -- Excessive Nesting: Deeply nested parentheses can cause stack overflows or performance issues in lexers that use recursive descent parsing.
Whitespace(1) | 

Comment( Tokenization Depth: The lexer must handle nesting levels beyond typical use cases.) | -- Tokenization Depth: The lexer must handle nesting levels beyond typical use cases.
Whitespace(3) | 



Keyword(SELECT) | SELECT
Whitespace(0) |  
Special(() | (
Special(() | (
Special(() | (
Special(() | (
Special(() | (
Special(() | (
Special(() | (
Identifier(1+2) | 1+2
Special()) | )
Special()) | )
Special()) | )
Special()) | )
Special()) | )
Special()) | )
Special()) | )
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Special(() | (
Special(() | (
Special(() | (
Special(() | (
Special(() | (
Identifier(3) | 3
Operator(*) | *
Identifier(4) | 4
Special()) | )
Special()) | )
Special()) | )
Special()) | )
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Special(() | (
Special(() | (
Identifier(5) | 5
Special()) | )
Special()) | )
Special()) | )
Special()) | )
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Special(() | (
Keyword(SELECT) | SELECT
Whitespace(0) |  
Special(() | (
Special(() | (
Special(() | (
Special(() | (
Special(() | (
Identifier(6) | 6
Special()) | )
Special()) | )
Special()) | )
Special()) | )
Special()) | )
Special()) | )
Special(;) | ;
Whitespace(1) | 

