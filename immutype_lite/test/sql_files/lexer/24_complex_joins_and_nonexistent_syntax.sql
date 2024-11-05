Lexer result:

Comment( Attempting to use RIGHT OUTER JOIN (SQLite does not support this).) | -- Attempting to use RIGHT OUTER JOIN (SQLite does not support this).
Whitespace(1) | 

Comment( Combining results with UNION.) | -- Combining results with UNION.
Whitespace(1) | 

Comment( Parser's error detection for unsupported syntax.) | -- Parser's error detection for unsupported syntax.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(t1) | t1
Special(() | (
Identifier(a) | a
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Special()) | )
Special(;) | ;
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(t2) | t2
Special(() | (
Identifier(a) | a
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(t1) | t1
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Numeric(1) | 1
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Numeric(2) | 2
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Numeric(3) | 3
Special()) | )
Special(;) | ;
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(t2) | t2
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Numeric(2) | 2
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Numeric(3) | 3
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Numeric(4) | 4
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(x) | x
Special(.) | .
Identifier(a) | a
Special(,) | ,
Whitespace(0) |  
Identifier(y) | y
Special(.) | .
Identifier(a) | a
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(t1) | t1
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(x) | x
Whitespace(0) |  
Keyword(LEFT) | LEFT
Whitespace(0) |  
Keyword(OUTER) | OUTER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(t2) | t2
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(y) | y
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(x) | x
Special(.) | .
Identifier(a) | a
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(y) | y
Special(.) | .
Identifier(a) | a
Whitespace(1) | 

Keyword(UNION) | UNION
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(x) | x
Special(.) | .
Identifier(a) | a
Special(,) | ,
Whitespace(0) |  
Identifier(y) | y
Special(.) | .
Identifier(a) | a
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(t1) | t1
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(x) | x
Whitespace(0) |  
Keyword(RIGHT) | RIGHT
Whitespace(0) |  
Keyword(OUTER) | OUTER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(t2) | t2
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(y) | y
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(x) | x
Special(.) | .
Identifier(a) | a
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(y) | y
Special(.) | .
Identifier(a) | a
Whitespace(1) | 

Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(0) |  
Numeric(1) | 1
Special(,) | ,
Whitespace(0) |  
Numeric(2) | 2
Special(;) | ;
Whitespace(1) | 

