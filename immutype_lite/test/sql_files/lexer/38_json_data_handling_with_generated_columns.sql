Lexer result:

Comment( Table Creation with Generated Columns: Creates a json_data table that stores JSON strings and uses generated columns to extract fields.) | -- Table Creation with Generated Columns: Creates a json_data table that stores JSON strings and uses generated columns to extract fields.
Whitespace(1) | 

Comment( Data Insertion: Inserts JSON data as text.) | -- Data Insertion: Inserts JSON data as text.
Whitespace(1) | 

Comment( Querying Generated Columns: Allows querying directly on extracted fields without parsing JSON manually.) | -- Querying Generated Columns: Allows querying directly on extracted fields without parsing JSON manually.
Whitespace(1) | 

Comment( Updating JSON Data: Updates the JSON field using json_set, and the generated columns automatically reflect the changes.) | -- Updating JSON Data: Updates the JSON field using json_set, and the generated columns automatically reflect the changes.
Whitespace(3) | 



Comment( Enable the JSON1 extension (if not already enabled)) | -- Enable the JSON1 extension (if not already enabled)
Whitespace(1) | 

Comment( This may require compiling SQLite with JSON1 support.) | -- This may require compiling SQLite with JSON1 support.
Whitespace(2) | 


Comment( Create a table to store JSON data) | -- Create a table to store JSON data
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(json_data) | json_data
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
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Identifier(name) | name
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(GENERATED) | GENERATED
Whitespace(0) |  
Keyword(ALWAYS) | ALWAYS
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Special(() | (
Identifier(json_extract) | json_extract
Special(() | (
Identifier(data) | data
Special(,) | ,
Whitespace(0) |  
StringLiteral($.name) | '$.name'
Special()) | )
Special()) | )
Whitespace(0) |  
Identifier(STORED) | STORED
Special(,) | ,
Whitespace(1) | 
    
Identifier(age) | age
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(GENERATED) | GENERATED
Whitespace(0) |  
Keyword(ALWAYS) | ALWAYS
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Special(() | (
Identifier(json_extract) | json_extract
Special(() | (
Identifier(data) | data
Special(,) | ,
Whitespace(0) |  
StringLiteral($.age) | '$.age'
Special()) | )
Special()) | )
Whitespace(0) |  
Identifier(STORED) | STORED
Special(,) | ,
Whitespace(1) | 
    
Identifier(city) | city
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(GENERATED) | GENERATED
Whitespace(0) |  
Keyword(ALWAYS) | ALWAYS
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Special(() | (
Identifier(json_extract) | json_extract
Special(() | (
Identifier(data) | data
Special(,) | ,
Whitespace(0) |  
StringLiteral($.address.city) | '$.address.city'
Special()) | )
Special()) | )
Whitespace(0) |  
Identifier(STORED) | STORED
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Insert sample JSON data) | -- Insert sample JSON data
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(json_data) | json_data
Whitespace(0) |  
Special(() | (
Identifier(data) | data
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
StringLiteral({"name": "Alice", "age": 30, "address": {"city": "New York", "zip": "10001"}}) | '{"name": "Alice", "age": 30, "address": {"city": "New York", "zip": "10001"}}'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral({"name": "Bob", "age": 25, "address": {"city": "Los Angeles", "zip": "90001"}}) | '{"name": "Bob", "age": 25, "address": {"city": "Los Angeles", "zip": "90001"}}'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Query the table using generated columns) | -- Query the table using generated columns
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(id) | id
Special(,) | ,
Whitespace(1) | 
    
Identifier(name) | name
Special(,) | ,
Whitespace(1) | 
    
Identifier(age) | age
Special(,) | ,
Whitespace(1) | 
    
Identifier(city) | city
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(json_data) | json_data
Whitespace(1) | 

Keyword(WHERE) | WHERE
Whitespace(1) | 
    
Identifier(city) | city
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(New York) | 'New York'
Special(;) | ;
Whitespace(2) | 


Comment( Update JSON data and observe changes in generated columns) | -- Update JSON data and observe changes in generated columns
Whitespace(1) | 

Keyword(UPDATE) | UPDATE
Whitespace(0) |  
Identifier(json_data) | json_data
Whitespace(1) | 

Keyword(SET) | SET
Whitespace(0) |  
Identifier(data) | data
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(json_set) | json_set
Special(() | (
Identifier(data) | data
Special(,) | ,
Whitespace(0) |  
StringLiteral($.age) | '$.age'
Special(,) | ,
Whitespace(0) |  
Identifier(31) | 31
Special()) | )
Whitespace(1) | 

Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(name) | name
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(Alice) | 'Alice'
Special(;) | ;
Whitespace(2) | 


Comment( Verify the update) | -- Verify the update
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(id) | id
Special(,) | ,
Whitespace(1) | 
    
Identifier(name) | name
Special(,) | ,
Whitespace(1) | 
    
Identifier(age) | age
Special(,) | ,
Whitespace(1) | 
    
Identifier(city) | city
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(json_data) | json_data
Whitespace(1) | 

Keyword(WHERE) | WHERE
Whitespace(1) | 
    
Identifier(name) | name
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(Alice) | 'Alice'
Special(;) | ;
Whitespace(1) | 

