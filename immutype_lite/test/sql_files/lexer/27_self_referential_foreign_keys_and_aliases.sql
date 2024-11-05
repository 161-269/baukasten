Lexer result:

Comment( Self-referencing foreign keys.) | -- Self-referencing foreign keys.
Whitespace(1) | 

Comment( Recursive data structures.) | -- Recursive data structures.
Whitespace(1) | 

Comment( Using table aliases for self-joins.) | -- Using table aliases for self-joins.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(hierarchy) | hierarchy
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
  
Identifier(name) | name
Whitespace(0) |  
Keyword(TEXT) | TEXT
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
Identifier(hierarchy) | hierarchy
Special(() | (
Identifier(id) | id
Special()) | )
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(hierarchy) | hierarchy
Whitespace(0) |  
Special(() | (
Identifier(id) | id
Special(,) | ,
Whitespace(0) |  
Identifier(parent_id) | parent_id
Special(,) | ,
Whitespace(0) |  
Identifier(name) | name
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(0) |  
StringLiteral(Root) | 'Root'
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Identifier(2) | 2
Special(,) | ,
Whitespace(0) |  
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
StringLiteral(Child) | 'Child'
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Identifier(3) | 3
Special(,) | ,
Whitespace(0) |  
Identifier(2) | 2
Special(,) | ,
Whitespace(0) |  
StringLiteral(Grandchild) | 'Grandchild'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(h1) | h1
Special(.) | .
Identifier(name) | name
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(child) | child
Special(,) | ,
Whitespace(0) |  
Identifier(h2) | h2
Special(.) | .
Identifier(name) | name
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(parent) | parent
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(hierarchy) | hierarchy
Whitespace(0) |  
Identifier(h1) | h1
Whitespace(1) | 

Keyword(LEFT) | LEFT
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(hierarchy) | hierarchy
Whitespace(0) |  
Identifier(h2) | h2
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(h1) | h1
Special(.) | .
Identifier(parent_id) | parent_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(h2) | h2
Special(.) | .
Identifier(id) | id
Special(;) | ;
Whitespace(1) | 

