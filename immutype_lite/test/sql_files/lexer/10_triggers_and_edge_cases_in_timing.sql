Lexer result:

Comment( Use of triggers with AFTER INSERT.) | -- Use of triggers with AFTER INSERT.
Whitespace(1) | 

Comment( Accessing NEW values within triggers.) | -- Accessing NEW values within triggers.
Whitespace(1) | 

Comment( String concatenation in SQL statements.) | -- String concatenation in SQL statements.
Whitespace(1) | 

Comment( Testing the parser's handling of trigger bodies.) | -- Testing the parser's handling of trigger bodies.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(log) | log
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
  
Identifier(entry) | entry
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(data) | data
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
  
Identifier(value) | value
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TRIGGER) | TRIGGER
Whitespace(0) |  
Identifier(data_after_insert) | data_after_insert
Whitespace(0) |  
Keyword(AFTER) | AFTER
Whitespace(0) |  
Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(data) | data
Whitespace(1) | 

Keyword(BEGIN) | BEGIN
Whitespace(1) | 
  
Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(log) | log
Whitespace(0) |  
Special(() | (
Identifier(entry) | entry
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(Inserted value: ) | 'Inserted value: '
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
Identifier(NEW) | NEW
Special(.) | .
Identifier(value) | value
Special()) | )
Special(;) | ;
Whitespace(1) | 

Keyword(END) | END
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
StringLiteral(Test) | 'Test'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(log) | log
Special(;) | ;
Whitespace(1) | 

