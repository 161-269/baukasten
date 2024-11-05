Lexer result:

Comment( Using ATTACH and DETACH commands.) | -- Using ATTACH and DETACH commands.
Whitespace(1) | 

Comment( Referencing tables in attached databases with a namespace.) | -- Referencing tables in attached databases with a namespace.
Whitespace(1) | 

Comment( Parser handling of multiple databases in the same session.) | -- Parser handling of multiple databases in the same session.
Whitespace(3) | 



Keyword(ATTACH) | ATTACH
Whitespace(0) |  
Keyword(DATABASE) | DATABASE
Whitespace(0) |  
StringLiteral(additional.db) | 'additional.db'
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(additional) | additional
Special(;) | ;
Whitespace(2) | 


Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(additional) | additional
Special(.) | .
Identifier(new_table) | new_table
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
  
Identifier(data) | data
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
Identifier(additional) | additional
Special(.) | .
Identifier(new_table) | new_table
Whitespace(0) |  
Special(() | (
Identifier(data) | data
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
StringLiteral(Attached DB Entry) | 'Attached DB Entry'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(SELECT) | SELECT
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(additional) | additional
Special(.) | .
Identifier(new_table) | new_table
Special(;) | ;
Whitespace(2) | 


Keyword(DETACH) | DETACH
Whitespace(0) |  
Keyword(DATABASE) | DATABASE
Whitespace(0) |  
Identifier(additional) | additional
Special(;) | ;
Whitespace(1) | 

