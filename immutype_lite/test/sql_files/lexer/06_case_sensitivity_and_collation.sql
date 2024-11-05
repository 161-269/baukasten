Lexer result:

Comment( Use of COLLATE NOCASE to make text comparisons case-insensitive.) | -- Use of COLLATE NOCASE to make text comparisons case-insensitive.
Whitespace(1) | 

Comment( Identifiers with mixed casing.) | -- Identifiers with mixed casing.
Whitespace(1) | 

Comment( Testing how the parser handles collation specifications.) | -- Testing how the parser handles collation specifications.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(CaseTest) | CaseTest
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
Whitespace(0) |  
Keyword(COLLATE) | COLLATE
Whitespace(0) |  
Identifier(NOCASE) | NOCASE
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(CaseTest) | CaseTest
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
Numeric(1) | 1
Special(,) | ,
Whitespace(0) |  
StringLiteral(Apple) | 'Apple'
Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Numeric(2) | 2
Special(,) | ,
Whitespace(0) |  
StringLiteral(apple) | 'apple'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(CaseTest) | CaseTest
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(value) | value
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(APPLE) | 'APPLE'
Special(;) | ;
Whitespace(1) | 

