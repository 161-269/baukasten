Lexer result:

Comment( Table Creation: Defines a user_profiles table with unique constraints on username and email.) | -- Table Creation: Defines a user_profiles table with unique constraints on username and email.
Whitespace(1) | 

Comment( Upsert Operation: Uses ON CONFLICT to update existing records when a conflict occurs on username.) | -- Upsert Operation: Uses ON CONFLICT to update existing records when a conflict occurs on username.
Whitespace(1) | 

Comment( Conflict Handling: Updates the email and last_login fields when an existing user is inserted again.) | -- Conflict Handling: Updates the email and last_login fields when an existing user is inserted again.
Whitespace(1) | 

Comment( Data Verification: Queries confirm that the upsert operation behaved as expected.) | -- Data Verification: Queries confirm that the upsert operation behaved as expected.
Whitespace(3) | 



Comment( Create a table for user profiles) | -- Create a table for user profiles
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(user_profiles) | user_profiles
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(user_id) | user_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
    
Identifier(username) | username
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
    
Identifier(last_login) | last_login
Whitespace(0) |  
Identifier(DATE) | DATE
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Insert initial data into user_profiles) | -- Insert initial data into user_profiles
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(user_profiles) | user_profiles
Whitespace(0) |  
Special(() | (
Identifier(username) | username
Special(,) | ,
Whitespace(0) |  
Identifier(email) | email
Special(,) | ,
Whitespace(0) |  
Identifier(last_login) | last_login
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
StringLiteral(alice) | 'alice'
Special(,) | ,
Whitespace(0) |  
StringLiteral(alice@example.com) | 'alice@example.com'
Special(,) | ,
Whitespace(0) |  
StringLiteral(2023-03-01) | '2023-03-01'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(bob) | 'bob'
Special(,) | ,
Whitespace(0) |  
StringLiteral(bob@example.com) | 'bob@example.com'
Special(,) | ,
Whitespace(0) |  
StringLiteral(2023-03-02) | '2023-03-02'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Use upsert to update last_login if the user already exists) | -- Use upsert to update last_login if the user already exists
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(user_profiles) | user_profiles
Whitespace(0) |  
Special(() | (
Identifier(username) | username
Special(,) | ,
Whitespace(0) |  
Identifier(email) | email
Special(,) | ,
Whitespace(0) |  
Identifier(last_login) | last_login
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
StringLiteral(alice) | 'alice'
Special(,) | ,
Whitespace(0) |  
StringLiteral(alice_new@example.com) | 'alice_new@example.com'
Special(,) | ,
Whitespace(0) |  
Identifier(DATE) | DATE
Special(() | (
StringLiteral(now) | 'now'
Special()) | )
Special()) | )
Whitespace(1) | 

Keyword(ON) | ON
Whitespace(0) |  
Keyword(CONFLICT) | CONFLICT
Special(() | (
Identifier(username) | username
Special()) | )
Whitespace(0) |  
Keyword(DO) | DO
Whitespace(0) |  
Keyword(UPDATE) | UPDATE
Whitespace(0) |  
Keyword(SET) | SET
Whitespace(1) | 
    
Identifier(email) | email
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(excluded) | excluded
Special(.) | .
Identifier(email) | email
Special(,) | ,
Whitespace(1) | 
    
Identifier(last_login) | last_login
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(excluded) | excluded
Special(.) | .
Identifier(last_login) | last_login
Special(;) | ;
Whitespace(2) | 


Comment( Verify that Alice's email and last_login have been updated) | -- Verify that Alice's email and last_login have been updated
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(user_id) | user_id
Special(,) | ,
Whitespace(1) | 
    
Identifier(username) | username
Special(,) | ,
Whitespace(1) | 
    
Identifier(email) | email
Special(,) | ,
Whitespace(1) | 
    
Identifier(last_login) | last_login
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(user_profiles) | user_profiles
Whitespace(1) | 

Keyword(WHERE) | WHERE
Whitespace(1) | 
    
Identifier(username) | username
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(alice) | 'alice'
Special(;) | ;
Whitespace(2) | 


Comment( Attempt to insert a new user without conflicts) | -- Attempt to insert a new user without conflicts
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(user_profiles) | user_profiles
Whitespace(0) |  
Special(() | (
Identifier(username) | username
Special(,) | ,
Whitespace(0) |  
Identifier(email) | email
Special(,) | ,
Whitespace(0) |  
Identifier(last_login) | last_login
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
StringLiteral(charlie) | 'charlie'
Special(,) | ,
Whitespace(0) |  
StringLiteral(charlie@example.com) | 'charlie@example.com'
Special(,) | ,
Whitespace(0) |  
Identifier(DATE) | DATE
Special(() | (
StringLiteral(now) | 'now'
Special()) | )
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Verify that Charlie has been added) | -- Verify that Charlie has been added
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(user_id) | user_id
Special(,) | ,
Whitespace(1) | 
    
Identifier(username) | username
Special(,) | ,
Whitespace(1) | 
    
Identifier(email) | email
Special(,) | ,
Whitespace(1) | 
    
Identifier(last_login) | last_login
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(user_profiles) | user_profiles
Special(;) | ;
Whitespace(1) | 

