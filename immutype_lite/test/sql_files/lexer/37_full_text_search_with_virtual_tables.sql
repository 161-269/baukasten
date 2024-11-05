Lexer result:

Comment( Virtual Table Creation: Uses fts5 to create a full-text search virtual table articles.) | -- Virtual Table Creation: Uses fts5 to create a full-text search virtual table articles.
Whitespace(1) | 

Comment( Data Insertion: Adds sample articles with titles and bodies.) | -- Data Insertion: Adds sample articles with titles and bodies.
Whitespace(1) | 

Comment( Full-Text Search Queries:) | -- Full-Text Search Queries:
Whitespace(1) | 

Comment( ) | -- 
Whitespace(1) | 

Comment(     Searches for articles matching specific terms using the MATCH operator.) | --     Searches for articles matching specific terms using the MATCH operator.
Whitespace(1) | 

Comment(     Uses snippet to extract and highlight matching text.) | --     Uses snippet to extract and highlight matching text.
Whitespace(1) | 

Comment(     Calculates relevance scores using the bm25 ranking function.) | --     Calculates relevance scores using the bm25 ranking function.
Whitespace(3) | 



Comment( Enable the FTS5 extension (if not already enabled)) | -- Enable the FTS5 extension (if not already enabled)
Whitespace(1) | 

Comment( This may require compiling SQLite with FTS5 support.) | -- This may require compiling SQLite with FTS5 support.
Whitespace(2) | 


Comment( Create a virtual table for articles using FTS5) | -- Create a virtual table for articles using FTS5
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(VIRTUAL) | VIRTUAL
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(articles) | articles
Whitespace(0) |  
Keyword(USING) | USING
Whitespace(0) |  
Identifier(fts5) | fts5
Special(() | (
Whitespace(1) | 
    
Identifier(title) | title
Special(,) | ,
Whitespace(1) | 
    
Identifier(body) | body
Special(,) | ,
Whitespace(1) | 
    
Identifier(content='') | content=''
Special(,) | ,
Whitespace(1) | 
    
Identifier(tokenize='porter') | tokenize='porter'
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Insert sample articles into the virtual table) | -- Insert sample articles into the virtual table
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(articles) | articles
Whitespace(0) |  
Special(() | (
Identifier(title) | title
Special(,) | ,
Whitespace(0) |  
Identifier(body) | body
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
StringLiteral(Introduction to SQLite) | 'Introduction to SQLite'
Special(,) | ,
Whitespace(0) |  
StringLiteral(SQLite is a lightweight, file-based database system.) | 'SQLite is a lightweight, file-based database system.'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Advanced SQLite Features) | 'Advanced SQLite Features'
Special(,) | ,
Whitespace(0) |  
StringLiteral(Explore advanced features like window functions and common table expressions.) | 'Explore advanced features like window functions and common table expressions.'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(SQLite and Full-Text Search) | 'SQLite and Full-Text Search'
Special(,) | ,
Whitespace(0) |  
StringLiteral(Implement full-text search using FTS5 extension in SQLite.) | 'Implement full-text search using FTS5 extension in SQLite.'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Perform a full-text search for articles containing 'sqlite' and 'features') | -- Perform a full-text search for articles containing 'sqlite' and 'features'
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(title) | title
Special(,) | ,
Whitespace(1) | 
    
Identifier(snippet) | snippet
Special(() | (
Identifier(articles) | articles
Special(,) | ,
Whitespace(0) |  
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
StringLiteral(<b>) | '<b>'
Special(,) | ,
Whitespace(0) |  
StringLiteral(</b>) | '</b>'
Special(,) | ,
Whitespace(0) |  
StringLiteral(...) | '...'
Special(,) | ,
Whitespace(0) |  
Identifier(10) | 10
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(snippet) | snippet
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(articles) | articles
Whitespace(1) | 

Keyword(WHERE) | WHERE
Whitespace(1) | 
    
Identifier(articles) | articles
Whitespace(0) |  
Keyword(MATCH) | MATCH
Whitespace(0) |  
StringLiteral(sqlite AND features) | 'sqlite AND features'
Special(;) | ;
Whitespace(2) | 


Comment( Display the relevance score using BM25 ranking) | -- Display the relevance score using BM25 ranking
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(title) | title
Special(,) | ,
Whitespace(1) | 
    
Identifier(bm25) | bm25
Special(() | (
Identifier(articles) | articles
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(score) | score
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(articles) | articles
Whitespace(1) | 

Keyword(WHERE) | WHERE
Whitespace(1) | 
    
Identifier(articles) | articles
Whitespace(0) |  
Keyword(MATCH) | MATCH
Whitespace(0) |  
StringLiteral(sqlite) | 'sqlite'
Whitespace(1) | 

Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
    
Identifier(score) | score
Special(;) | ;
Whitespace(1) | 

