Lexer result:

Comment( Keywords as Identifiers Without Quotes: Using SQL keywords as column names without quoting can mislead the lexer into interpreting them as part of the SQL syntax.) | -- Keywords as Identifiers Without Quotes: Using SQL keywords as column names without quoting can mislead the lexer into interpreting them as part of the SQL syntax.
Whitespace(1) | 

Comment( Context-Sensitive Tokenization: The lexer must be able to determine when a keyword is being used as an identifier versus its role in SQL syntax.) | -- Context-Sensitive Tokenization: The lexer must be able to determine when a keyword is being used as an identifier versus its role in SQL syntax.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(keyword_confusion) | keyword_confusion
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Keyword(SELECT) | select
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Special(,) | ,
Whitespace(1) | 
    
Keyword(FROM) | from
Whitespace(0) |  
Keyword(TEXT) | TEXT
Special(,) | ,
Whitespace(1) | 
    
Keyword(WHERE) | where
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
Identifier(keyword_confusion) | keyword_confusion
Whitespace(0) |  
Special(() | (
Keyword(SELECT) | select
Special(,) | ,
Whitespace(0) |  
Keyword(FROM) | from
Special(,) | ,
Whitespace(0) |  
Keyword(WHERE) | where
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
StringLiteral(Data) | 'Data'
Special(,) | ,
Whitespace(0) |  
Identifier(2) | 2
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Keyword(SELECT) | select
Special(,) | ,
Whitespace(0) |  
Keyword(FROM) | from
Special(,) | ,
Whitespace(0) |  
Keyword(WHERE) | where
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(keyword_confusion) | keyword_confusion
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Keyword(WHERE) | where
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(2) | 2
Special(;) | ;
Whitespace(1) | 

