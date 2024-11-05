Lexer result:

Comment( Escaped Quotes in Identifiers: The table name includes escaped quotes, testing the lexer's ability to handle escaped characters in identifiers.) | -- Escaped Quotes in Identifiers: The table name includes escaped quotes, testing the lexer's ability to handle escaped characters in identifiers.
Whitespace(1) | 

Comment( Multiline String Literals: SQLite supports multiline string literals, which can cause issues if the lexer expects strings to be on a single line.) | -- Multiline String Literals: SQLite supports multiline string literals, which can cause issues if the lexer expects strings to be on a single line.
Whitespace(1) | 

Comment( Backslashes and Quotes in Strings: Strings containing backslashes and various quote types can confuse lexers that do not handle escape sequences correctly.) | -- Backslashes and Quotes in Strings: Strings containing backslashes and various quote types can confuse lexers that do not handle escape sequences correctly.
Whitespace(1) | 

Comment( Hexadecimal Literals and Functions: Mixing hexadecimal string literals with functions like char() and concatenation operators can complicate tokenization.) | -- Hexadecimal Literals and Functions: Mixing hexadecimal string literals with functions like char() and concatenation operators can complicate tokenization.
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(strange\"table) | "strange\"table"
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
Identifier(strange\"table) | "strange\"table"
Whitespace(0) |  
Special(() | (
Identifier(data) | data
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
StringLiteral(Line1
    Line2) | 'Line1
    Line2'
Whitespace(1) | 

Special()) | )
Special(,) | ,
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
StringLiteral(Text with backslashes \\ and quotes \) | 'Text with backslashes \\ and quotes \'
Whitespace(0) |  
Identifier( '''
), (
    X'48656C6C6F20576F726C64' || char(0x0A) || 'Newline character'
);

SELECT * FROM "strange\"table) | " '''
), (
    X'48656C6C6F20576F726C64' || char(0x0A) || 'Newline character'
);

SELECT * FROM "strange\"table"
Special(;) | ;
Whitespace(1) | 

