Lexer result:

Comment( Use of WITH RECURSIVE for CTEs.) | -- Use of WITH RECURSIVE for CTEs.
Whitespace(1) | 

Comment( Recursive queries.) | -- Recursive queries.
Whitespace(1) | 

Comment( Testing the parser's ability to handle advanced query structures.) | -- Testing the parser's ability to handle advanced query structures.
Whitespace(3) | 



Keyword(WITH) | WITH
Whitespace(0) |  
Keyword(RECURSIVE) | RECURSIVE
Whitespace(1) | 
  
Identifier(cnt) | cnt
Special(() | (
Identifier(x) | x
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(1) | 1
Whitespace(1) | 
    
Keyword(UNION) | UNION
Whitespace(0) |  
Keyword(ALL) | ALL
Whitespace(1) | 
    
Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(x+1) | x+1
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(cnt) | cnt
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(x) | x
Whitespace(0) |  
Operator(<) | <
Whitespace(0) |  
Identifier(5) | 5
Whitespace(1) | 
  
Special()) | )
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(x) | x
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(cnt) | cnt
Special(;) | ;
Whitespace(1) | 

