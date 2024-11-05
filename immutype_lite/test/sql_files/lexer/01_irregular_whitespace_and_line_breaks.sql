Lexer result:

Comment( Excessive and irregular spaces.) | -- Excessive and irregular spaces.
Whitespace(1) | 

Comment( Line breaks inserted at unconventional points.) | -- Line breaks inserted at unconventional points.
Whitespace(1) | 

Comment( Table name enclosed in quotes.) | -- Table name enclosed in quotes.
Whitespace(1) | 

Comment( Missing spaces after commas in the INSERT statement.) | -- Missing spaces after commas in the INSERT statement.
Whitespace(1) | 

Comment( Inconsistent casing in SQL keywords.) | -- Inconsistent casing in SQL keywords.
Whitespace(3) | 


  
Keyword(CREATE) | CREATE
Whitespace(0) |     
Keyword(TABLE) | TABLE
Whitespace(0) |    
Identifier(MyTable) | "MyTable"
Whitespace(1) | 

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
Whitespace(0) |     
Identifier(name) | name
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
Identifier(MyTable) | "MyTable"
Special(() | (
Identifier(id) | id
Special(,) | ,
Identifier(name) | name
Special()) | )
Keyword(VALUES) | VALUES
Special(() | (
Identifier(1) | 1
Special(,) | ,
StringLiteral(Alice) | 'Alice'
Special()) | )
Special(,) | ,
Special(() | (
Identifier(2) | 2
Special(,) | ,
StringLiteral(Bob) | 'Bob'
Special()) | )
Special(;) | ;
Whitespace(2) | 

 
Keyword(SELECT) | SELECT
Whitespace(0) |   
Special(*) | *
Whitespace(0) |   
Keyword(FROM) | FROM
Whitespace(1) | 

Identifier(MyTable) | "MyTable"
Special(;) | ;
Whitespace(2) | 


