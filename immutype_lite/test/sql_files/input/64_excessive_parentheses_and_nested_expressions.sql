-- Excessive Nesting: Deeply nested parentheses can cause stack overflows or performance issues in lexers that use recursive descent parsing.
-- Tokenization Depth: The lexer must handle nesting levels beyond typical use cases.


SELECT (((((((1+2))))))) * (((((3*4))))), (((5)))) FROM (SELECT (((((6))))));
