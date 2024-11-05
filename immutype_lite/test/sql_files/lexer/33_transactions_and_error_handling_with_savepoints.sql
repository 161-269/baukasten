Lexer result:

Comment( Transaction Management: Uses transactions and savepoints to ensure atomicity of multiple operations.) | -- Transaction Management: Uses transactions and savepoints to ensure atomicity of multiple operations.
Whitespace(1) | 

Comment( Inventory Update and Order Insertion: Updates inventory quantities and inserts corresponding orders.) | -- Inventory Update and Order Insertion: Updates inventory quantities and inserts corresponding orders.
Whitespace(1) | 

Comment( Error Checking with RAISE(ABORT): Checks for negative inventory quantities and aborts the transaction if detected.) | -- Error Checking with RAISE(ABORT): Checks for negative inventory quantities and aborts the transaction if detected.
Whitespace(1) | 

Comment( Exception Handling: If an error occurs, rolls back to the savepoint and commits the transaction to release locks.) | -- Exception Handling: If an error occurs, rolls back to the savepoint and commits the transaction to release locks.
Whitespace(3) | 



Comment( Create tables for orders and inventory) | -- Create tables for orders and inventory
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(inventory) | inventory
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(product_id) | product_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
    
Identifier(product_name) | product_name
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Identifier(quantity) | quantity
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(0) |  
Keyword(CHECK) | CHECK
Whitespace(0) |  
Special(() | (
Identifier(quantity) | quantity
Whitespace(0) |  
Operator(>=) | >=
Whitespace(0) |  
Numeric(0) | 0
Special()) | )
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(orders) | orders
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(order_id) | order_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
    
Identifier(product_id) | product_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Identifier(order_quantity) | order_quantity
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(0) |  
Keyword(CHECK) | CHECK
Whitespace(0) |  
Special(() | (
Identifier(order_quantity) | order_quantity
Whitespace(0) |  
Operator(>) | >
Whitespace(0) |  
Numeric(0) | 0
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Identifier(order_date) | order_date
Whitespace(0) |  
Identifier(DATE) | DATE
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Keyword(FOREIGN) | FOREIGN
Whitespace(0) |  
Keyword(KEY) | KEY
Whitespace(0) |  
Special(() | (
Identifier(product_id) | product_id
Special()) | )
Whitespace(0) |  
Keyword(REFERENCES) | REFERENCES
Whitespace(0) |  
Identifier(inventory) | inventory
Special(() | (
Identifier(product_id) | product_id
Special()) | )
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Insert sample data into inventory) | -- Insert sample data into inventory
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(inventory) | inventory
Whitespace(0) |  
Special(() | (
Identifier(product_id) | product_id
Special(,) | ,
Whitespace(0) |  
Identifier(product_name) | product_name
Special(,) | ,
Whitespace(0) |  
Identifier(quantity) | quantity
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
Numeric(101) | 101
Special(,) | ,
Whitespace(0) |  
StringLiteral(Widget) | 'Widget'
Special(,) | ,
Whitespace(0) |  
Numeric(50) | 50
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
Numeric(102) | 102
Special(,) | ,
Whitespace(0) |  
StringLiteral(Gadget) | 'Gadget'
Special(,) | ,
Whitespace(0) |  
Numeric(75) | 75
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
Numeric(103) | 103
Special(,) | ,
Whitespace(0) |  
StringLiteral(Thingamajig) | 'Thingamajig'
Special(,) | ,
Whitespace(0) |  
Numeric(100) | 100
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Begin a transaction to process multiple orders atomically) | -- Begin a transaction to process multiple orders atomically
Whitespace(1) | 

Keyword(BEGIN) | BEGIN
Whitespace(0) |  
Keyword(TRANSACTION) | TRANSACTION
Special(;) | ;
Whitespace(2) | 


Comment( Set a savepoint in case we need to roll back to this point) | -- Set a savepoint in case we need to roll back to this point
Whitespace(1) | 

Keyword(SAVEPOINT) | SAVEPOINT
Whitespace(0) |  
Identifier(order_processing) | order_processing
Special(;) | ;
Whitespace(2) | 


Comment( Attempt to process an order for Widgets) | -- Attempt to process an order for Widgets
Whitespace(1) | 

Keyword(UPDATE) | UPDATE
Whitespace(0) |  
Identifier(inventory) | inventory
Whitespace(1) | 

Keyword(SET) | SET
Whitespace(0) |  
Identifier(quantity) | quantity
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(quantity) | quantity
Whitespace(0) |  
Operator(-) | -
Whitespace(0) |  
Numeric(20) | 20
Whitespace(1) | 

Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(product_id) | product_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Numeric(101) | 101
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(orders) | orders
Whitespace(0) |  
Special(() | (
Identifier(product_id) | product_id
Special(,) | ,
Whitespace(0) |  
Identifier(order_quantity) | order_quantity
Special(,) | ,
Whitespace(0) |  
Identifier(order_date) | order_date
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
Numeric(101) | 101
Special(,) | ,
Whitespace(0) |  
Numeric(20) | 20
Special(,) | ,
Whitespace(0) |  
Identifier(DATE) | DATE
Special(() | (
StringLiteral(now) | 'now'
Special()) | )
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Check if inventory quantity went negative) | -- Check if inventory quantity went negative
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(0) |  
Keyword(CASE) | CASE
Whitespace(1) | 
    
Keyword(WHEN) | WHEN
Whitespace(0) |  
Identifier(quantity) | quantity
Whitespace(0) |  
Operator(<) | <
Whitespace(0) |  
Numeric(0) | 0
Whitespace(0) |  
Keyword(THEN) | THEN
Whitespace(0) |  
Keyword(RAISE) | RAISE
Special(() | (
Keyword(ABORT) | ABORT
Special(,) | ,
Whitespace(0) |  
StringLiteral(Insufficient inventory for product_id 101) | 'Insufficient inventory for product_id 101'
Special()) | )
Whitespace(1) | 

Keyword(END) | END
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(inventory) | inventory
Whitespace(1) | 

Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(product_id) | product_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Numeric(101) | 101
Special(;) | ;
Whitespace(2) | 


Comment( Attempt to process an order for Gadgets) | -- Attempt to process an order for Gadgets
Whitespace(1) | 

Keyword(UPDATE) | UPDATE
Whitespace(0) |  
Identifier(inventory) | inventory
Whitespace(1) | 

Keyword(SET) | SET
Whitespace(0) |  
Identifier(quantity) | quantity
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(quantity) | quantity
Whitespace(0) |  
Operator(-) | -
Whitespace(0) |  
Numeric(80) | 80
Whitespace(1) | 

Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(product_id) | product_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Numeric(102) | 102
Special(;) | ;
Whitespace(2) | 


Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(orders) | orders
Whitespace(0) |  
Special(() | (
Identifier(product_id) | product_id
Special(,) | ,
Whitespace(0) |  
Identifier(order_quantity) | order_quantity
Special(,) | ,
Whitespace(0) |  
Identifier(order_date) | order_date
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
Numeric(102) | 102
Special(,) | ,
Whitespace(0) |  
Numeric(80) | 80
Special(,) | ,
Whitespace(0) |  
Identifier(DATE) | DATE
Special(() | (
StringLiteral(now) | 'now'
Special()) | )
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Check if inventory quantity went negative) | -- Check if inventory quantity went negative
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(0) |  
Keyword(CASE) | CASE
Whitespace(1) | 
    
Keyword(WHEN) | WHEN
Whitespace(0) |  
Identifier(quantity) | quantity
Whitespace(0) |  
Operator(<) | <
Whitespace(0) |  
Numeric(0) | 0
Whitespace(0) |  
Keyword(THEN) | THEN
Whitespace(0) |  
Keyword(RAISE) | RAISE
Special(() | (
Keyword(ABORT) | ABORT
Special(,) | ,
Whitespace(0) |  
StringLiteral(Insufficient inventory for product_id 102) | 'Insufficient inventory for product_id 102'
Special()) | )
Whitespace(1) | 

Keyword(END) | END
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(inventory) | inventory
Whitespace(1) | 

Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(product_id) | product_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Numeric(102) | 102
Special(;) | ;
Whitespace(2) | 


Comment( Commit the transaction if all operations succeeded) | -- Commit the transaction if all operations succeeded
Whitespace(1) | 

Keyword(RELEASE) | RELEASE
Whitespace(0) |  
Keyword(SAVEPOINT) | SAVEPOINT
Whitespace(0) |  
Identifier(order_processing) | order_processing
Special(;) | ;
Whitespace(1) | 

Keyword(COMMIT) | COMMIT
Special(;) | ;
Whitespace(2) | 


Comment( Exception handling: Roll back to savepoint if an error occurred) | -- Exception handling: Roll back to savepoint if an error occurred
Whitespace(1) | 

Keyword(ROLLBACK) | ROLLBACK
Whitespace(0) |  
Keyword(TO) | TO
Whitespace(0) |  
Identifier(order_processing) | order_processing
Special(;) | ;
Whitespace(1) | 

Keyword(COMMIT) | COMMIT
Special(;) | ;
Whitespace(1) | 

