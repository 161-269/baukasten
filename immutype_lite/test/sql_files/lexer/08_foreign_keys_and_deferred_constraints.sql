Lexer result:

Comment( Deferred foreign key constraints.) | -- Deferred foreign key constraints.
Whitespace(1) | 

Comment( Transactions with BEGIN TRANSACTION and COMMIT.) | -- Transactions with BEGIN TRANSACTION and COMMIT.
Whitespace(1) | 

Comment( Ordering of inserts that rely on deferred constraint checking.) | -- Ordering of inserts that rely on deferred constraint checking.
Whitespace(1) | 

Comment( Use of PRAGMA statements.) | -- Use of PRAGMA statements.
Whitespace(3) | 



Keyword(PRAGMA) | PRAGMA
Whitespace(0) |  
Identifier(foreign_keys) | foreign_keys
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Keyword(ON) | ON
Special(;) | ;
Whitespace(2) | 


Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(parent) | parent
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
  
Identifier(id) | id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(child) | child
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
  
Identifier(id) | id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
  
Identifier(parent_id) | parent_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Special(,) | ,
Whitespace(1) | 
  
Keyword(FOREIGN) | FOREIGN
Whitespace(0) |  
Keyword(KEY) | KEY
Special(() | (
Identifier(parent_id) | parent_id
Special()) | )
Whitespace(0) |  
Keyword(REFERENCES) | REFERENCES
Whitespace(0) |  
Identifier(parent) | parent
Special(() | (
Identifier(id) | id
Special()) | )
Whitespace(0) |  
Keyword(DEFERRABLE) | DEFERRABLE
Whitespace(0) |  
Keyword(INITIALLY) | INITIALLY
Whitespace(0) |  
Keyword(DEFERRED) | DEFERRED
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(BEGIN) | BEGIN
Whitespace(0) |  
Keyword(TRANSACTION) | TRANSACTION
Special(;) | ;
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(child) | child
Whitespace(0) |  
Special(() | (
Identifier(id) | id
Special(,) | ,
Whitespace(0) |  
Identifier(parent_id) | parent_id
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
Identifier(1) | 1
Special()) | )
Special(;) | ;
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(parent) | parent
Whitespace(0) |  
Special(() | (
Identifier(id) | id
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(1) | 1
Special()) | )
Special(;) | ;
Whitespace(1) | 

Keyword(COMMIT) | COMMIT
Special(;) | ;
Whitespace(1) | 

