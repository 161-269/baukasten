Lexer result:

Comment( Non-ASCII Unicode characters in table and column names.) | -- Non-ASCII Unicode characters in table and column names.
Whitespace(1) | 

Comment( Unicode string literals.) | -- Unicode string literals.
Whitespace(1) | 

Comment( Testing parser's support for international character sets.) | -- Testing parser's support for international character sets.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(数据) | 数据
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
  
Identifier(编号) | 编号
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
  
Identifier(值) | 值
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
Identifier(数据) | 数据
Whitespace(0) |  
Special(() | (
Identifier(编号) | 编号
Special(,) | ,
Whitespace(0) |  
Identifier(值) | 值
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
StringLiteral(测试) | '测试'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(值) | 值
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(数据) | 数据
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(编号) | 编号
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(1) | 1
Special(;) | ;
Whitespace(1) | 

