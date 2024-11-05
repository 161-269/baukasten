Lexer result:

Comment( Creating virtual tables with fts5.) | -- Creating virtual tables with fts5.
Whitespace(1) | 

Comment( Using custom tokenizers.) | -- Using custom tokenizers.
Whitespace(1) | 

Comment( Parser's handling of virtual table syntax and full-text search queries.) | -- Parser's handling of virtual table syntax and full-text search queries.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(VIRTUAL) | VIRTUAL
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(fts_test) | fts_test
Whitespace(0) |  
Keyword(USING) | USING
Whitespace(0) |  
Identifier(fts5) | fts5
Special(() | (
Identifier(content) | content
Special(,) | ,
Whitespace(0) |  
Identifier(tokenize) | tokenize
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(porter) | 'porter'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(fts_test) | fts_test
Whitespace(0) |  
Special(() | (
Identifier(content) | content
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(This is a test of the full-text search capabilities.) | 'This is a test of the full-text search capabilities.'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(fts_test) | fts_test
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(fts_test) | fts_test
Whitespace(0) |  
Keyword(MATCH) | MATCH
Whitespace(0) |  
StringLiteral(test) | 'test'
Special(;) | ;
Whitespace(1) | 

