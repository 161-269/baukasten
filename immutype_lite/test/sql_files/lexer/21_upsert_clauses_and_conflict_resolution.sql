Lexer result:

Comment( ON CONFLICT DO UPDATE (UPSERT) syntax.) | -- ON CONFLICT DO UPDATE (UPSERT) syntax.
Whitespace(1) | 

Comment( Using excluded table alias in updates.) | -- Using excluded table alias in updates.
Whitespace(1) | 

Comment( String concatenation in update statements.) | -- String concatenation in update statements.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(upsert_test) | upsert_test
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


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(upsert_test) | upsert_test
Whitespace(0) |  
Special(() | (
Identifier(id) | id
Special(,) | ,
Whitespace(0) |  
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
StringLiteral(Initial Value) | 'Initial Value'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(upsert_test) | upsert_test
Whitespace(0) |  
Special(() | (
Identifier(id) | id
Special(,) | ,
Whitespace(0) |  
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
StringLiteral(Updated Value) | 'Updated Value'
Special()) | )
Whitespace(1) | 
  
Keyword(ON) | ON
Whitespace(0) |  
Keyword(CONFLICT) | CONFLICT
Special(() | (
Identifier(id) | id
Special()) | )
Whitespace(0) |  
Keyword(DO) | DO
Whitespace(0) |  
Keyword(UPDATE) | UPDATE
Whitespace(0) |  
Keyword(SET) | SET
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(excluded) | excluded
Special(.) | .
Identifier(value) | value
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
StringLiteral( (Upserted)) | ' (Upserted)'
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(upsert_test) | upsert_test
Special(;) | ;
Whitespace(1) | 

