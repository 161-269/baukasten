Lexer result:

Comment( Table Creation and Indexing: Creates a customers table and indexes on last_name and signup_date to optimize search queries.) | -- Table Creation and Indexing: Creates a customers table and indexes on last_name and signup_date to optimize search queries.
Whitespace(1) | 

Comment( Data Insertion: Inserts sample customer data.) | -- Data Insertion: Inserts sample customer data.
Whitespace(1) | 

Comment( Optimized Query: Searches for customers who signed up in a specific date range, leveraging the index on signup_date.) | -- Optimized Query: Searches for customers who signed up in a specific date range, leveraging the index on signup_date.
Whitespace(1) | 

Comment( Query Plan Analysis: Uses EXPLAIN QUERY PLAN to verify that the index is being utilized by SQLite's query planner.) | -- Query Plan Analysis: Uses EXPLAIN QUERY PLAN to verify that the index is being utilized by SQLite's query planner.
Whitespace(3) | 



Comment( Create a table for customer data) | -- Create a table for customer data
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(customers) | customers
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(customer_id) | customer_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
    
Identifier(first_name) | first_name
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Identifier(last_name) | last_name
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Identifier(email) | email
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(UNIQUE) | UNIQUE
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Identifier(signup_date) | signup_date
Whitespace(0) |  
Identifier(DATE) | DATE
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Create indexes to optimize queries) | -- Create indexes to optimize queries
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(INDEX) | INDEX
Whitespace(0) |  
Identifier(idx_customers_last_name) | idx_customers_last_name
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(customers) | customers
Special(() | (
Identifier(last_name) | last_name
Special()) | )
Special(;) | ;
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(INDEX) | INDEX
Whitespace(0) |  
Identifier(idx_customers_signup_date) | idx_customers_signup_date
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(customers) | customers
Special(() | (
Identifier(signup_date) | signup_date
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Insert sample data into customers table) | -- Insert sample data into customers table
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(customers) | customers
Whitespace(0) |  
Special(() | (
Identifier(first_name) | first_name
Special(,) | ,
Whitespace(0) |  
Identifier(last_name) | last_name
Special(,) | ,
Whitespace(0) |  
Identifier(email) | email
Special(,) | ,
Whitespace(0) |  
Identifier(signup_date) | signup_date
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
StringLiteral(John) | 'John'
Special(,) | ,
Whitespace(0) |  
StringLiteral(Doe) | 'Doe'
Special(,) | ,
Whitespace(0) |  
StringLiteral(john.doe@example.com) | 'john.doe@example.com'
Special(,) | ,
Whitespace(0) |  
StringLiteral(2023-01-10) | '2023-01-10'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Jane) | 'Jane'
Special(,) | ,
Whitespace(0) |  
StringLiteral(Smith) | 'Smith'
Special(,) | ,
Whitespace(0) |  
StringLiteral(jane.smith@example.com) | 'jane.smith@example.com'
Special(,) | ,
Whitespace(0) |  
StringLiteral(2023-01-15) | '2023-01-15'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Emily) | 'Emily'
Special(,) | ,
Whitespace(0) |  
StringLiteral(Jones) | 'Jones'
Special(,) | ,
Whitespace(0) |  
StringLiteral(emily.jones@example.com) | 'emily.jones@example.com'
Special(,) | ,
Whitespace(0) |  
StringLiteral(2023-02-20) | '2023-02-20'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Michael) | 'Michael'
Special(,) | ,
Whitespace(0) |  
StringLiteral(Brown) | 'Brown'
Special(,) | ,
Whitespace(0) |  
StringLiteral(michael.brown@example.com) | 'michael.brown@example.com'
Special(,) | ,
Whitespace(0) |  
StringLiteral(2023-03-05) | '2023-03-05'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Query to find customers who signed up in February) | -- Query to find customers who signed up in February
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(customer_id) | customer_id
Special(,) | ,
Whitespace(1) | 
    
Identifier(first_name) | first_name
Special(,) | ,
Whitespace(1) | 
    
Identifier(last_name) | last_name
Special(,) | ,
Whitespace(1) | 
    
Identifier(email) | email
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(customers) | customers
Whitespace(1) | 

Keyword(WHERE) | WHERE
Whitespace(1) | 
    
Identifier(signup_date) | signup_date
Whitespace(0) |  
Keyword(BETWEEN) | BETWEEN
Whitespace(0) |  
StringLiteral(2023-02-01) | '2023-02-01'
Whitespace(0) |  
Keyword(AND) | AND
Whitespace(0) |  
StringLiteral(2023-02-28) | '2023-02-28'
Special(;) | ;
Whitespace(2) | 


Comment( Analyze query plan to ensure indexes are used) | -- Analyze query plan to ensure indexes are used
Whitespace(1) | 

Keyword(EXPLAIN) | EXPLAIN
Whitespace(0) |  
Keyword(QUERY) | QUERY
Whitespace(0) |  
Keyword(PLAN) | PLAN
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(customer_id) | customer_id
Special(,) | ,
Whitespace(1) | 
    
Identifier(first_name) | first_name
Special(,) | ,
Whitespace(1) | 
    
Identifier(last_name) | last_name
Special(,) | ,
Whitespace(1) | 
    
Identifier(email) | email
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(customers) | customers
Whitespace(1) | 

Keyword(WHERE) | WHERE
Whitespace(1) | 
    
Identifier(signup_date) | signup_date
Whitespace(0) |  
Keyword(BETWEEN) | BETWEEN
Whitespace(0) |  
StringLiteral(2023-02-01) | '2023-02-01'
Whitespace(0) |  
Keyword(AND) | AND
Whitespace(0) |  
StringLiteral(2023-02-28) | '2023-02-28'
Special(;) | ;
Whitespace(1) | 

