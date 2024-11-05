Lexer result:

Comment( Subqueries in SET and WHERE clauses within UPDATE.) | -- Subqueries in SET and WHERE clauses within UPDATE.
Whitespace(1) | 

Comment( Multiple subqueries in a single statement.) | -- Multiple subqueries in a single statement.
Whitespace(1) | 

Comment( Parser's ability to handle nested queries.) | -- Parser's ability to handle nested queries.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(subquery_test) | subquery_test
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
Keyword(INTEGER) | INTEGER
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(subquery_test) | subquery_test
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
Identifier(10) | 10
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Identifier(2) | 2
Special(,) | ,
Whitespace(0) |  
Identifier(20) | 20
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(UPDATE) | UPDATE
Whitespace(0) |  
Identifier(subquery_test) | subquery_test
Whitespace(1) | 

Keyword(SET) | SET
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Special(() | (
Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(MAX) | MAX
Special(() | (
Identifier(value) | value
Special()) | )
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(subquery_test) | subquery_test
Special()) | )
Whitespace(0) |  
Operator(+) | +
Whitespace(0) |  
Special(() | (
Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(COUNT) | COUNT
Special(() | (
Operator(*) | *
Special()) | )
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(subquery_test) | subquery_test
Special()) | )
Whitespace(1) | 

Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(id) | id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Special(() | (
Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(MIN) | MIN
Special(() | (
Identifier(id) | id
Special()) | )
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(subquery_test) | subquery_test
Special()) | )
Special(;) | ;
Whitespace(1) | 

