Lexer result:

Comment( Using SAVEPOINT and ROLLBACK TO for nested transactions.) | -- Using SAVEPOINT and ROLLBACK TO for nested transactions.
Whitespace(1) | 

Comment( Transactions within transactions.) | -- Transactions within transactions.
Whitespace(1) | 

Comment( Parser's handling of transaction control flow.) | -- Parser's handling of transaction control flow.
Whitespace(3) | 



Keyword(BEGIN) | BEGIN
Whitespace(0) |  
Keyword(TRANSACTION) | TRANSACTION
Special(;) | ;
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(data) | data
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(Outer Transaction) | 'Outer Transaction'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SAVEPOINT) | SAVEPOINT
Whitespace(0) |  
Identifier(inner_savepoint) | inner_savepoint
Special(;) | ;
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(data) | data
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(Inner Transaction) | 'Inner Transaction'
Special()) | )
Special(;) | ;
Whitespace(1) | 

Keyword(ROLLBACK) | ROLLBACK
Whitespace(0) |  
Keyword(TO) | TO
Whitespace(0) |  
Identifier(inner_savepoint) | inner_savepoint
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(data) | data
Whitespace(0) |  
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(After Rollback) | 'After Rollback'
Special()) | )
Special(;) | ;
Whitespace(1) | 

Keyword(COMMIT) | COMMIT
Special(;) | ;
Whitespace(1) | 

