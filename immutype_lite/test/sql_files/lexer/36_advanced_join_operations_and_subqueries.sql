Lexer result:

Comment( Tables Creation and Data Insertion: Defines products, categories, orders, and order_items tables with appropriate relationships and inserts sample data.) | -- Tables Creation and Data Insertion: Defines products, categories, orders, and order_items tables with appropriate relationships and inserts sample data.
Whitespace(1) | 

Comment( Order Summary Query:) | -- Order Summary Query:
Whitespace(1) | 

Comment( ) | -- 
Whitespace(1) | 

Comment(     Joins multiple tables to calculate the total amount per order.) | --     Joins multiple tables to calculate the total amount per order.
Whitespace(1) | 

Comment(     Uses SUM to compute total amounts and GROUP_CONCAT to list ordered items.) | --     Uses SUM to compute total amounts and GROUP_CONCAT to list ordered items.
Whitespace(1) | 

Comment( ) | -- 
Whitespace(1) | 

Comment( Top-Selling Category Subquery:) | -- Top-Selling Category Subquery:
Whitespace(1) | 

Comment( ) | -- 
Whitespace(1) | 

Comment(     Calculates total quantities sold per category.) | --     Calculates total quantities sold per category.
Whitespace(1) | 

Comment(     Uses a subquery in the HAVING clause to find the category with the maximum total quantity sold.) | --     Uses a subquery in the HAVING clause to find the category with the maximum total quantity sold.
Whitespace(3) | 



Comment( Create a table for products) | -- Create a table for products
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(products) | products
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
    
Identifier(category_id) | category_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Identifier(price) | price
Whitespace(0) |  
Keyword(REAL) | REAL
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
Identifier(category_id) | category_id
Special()) | )
Whitespace(0) |  
Keyword(REFERENCES) | REFERENCES
Whitespace(0) |  
Identifier(categories) | categories
Special(() | (
Identifier(category_id) | category_id
Special()) | )
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Create a table for categories) | -- Create a table for categories
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(categories) | categories
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(category_id) | category_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
    
Identifier(category_name) | category_name
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Create a table for orders) | -- Create a table for orders
Whitespace(1) | 

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
    
Identifier(order_date) | order_date
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


Comment( Create a table for order items) | -- Create a table for order items
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(order_items) | order_items
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(order_id) | order_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
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
Operator(>) | >
Whitespace(0) |  
Numeric(0) | 0
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Keyword(FOREIGN) | FOREIGN
Whitespace(0) |  
Keyword(KEY) | KEY
Whitespace(0) |  
Special(() | (
Identifier(order_id) | order_id
Special()) | )
Whitespace(0) |  
Keyword(REFERENCES) | REFERENCES
Whitespace(0) |  
Identifier(orders) | orders
Special(() | (
Identifier(order_id) | order_id
Special()) | )
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
Identifier(products) | products
Special(() | (
Identifier(product_id) | product_id
Special()) | )
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Insert sample data into categories) | -- Insert sample data into categories
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(categories) | categories
Whitespace(0) |  
Special(() | (
Identifier(category_id) | category_id
Special(,) | ,
Whitespace(0) |  
Identifier(category_name) | category_name
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
Numeric(1) | 1
Special(,) | ,
Whitespace(0) |  
StringLiteral(Electronics) | 'Electronics'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
Numeric(2) | 2
Special(,) | ,
Whitespace(0) |  
StringLiteral(Books) | 'Books'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
Numeric(3) | 3
Special(,) | ,
Whitespace(0) |  
StringLiteral(Clothing) | 'Clothing'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Insert sample data into products) | -- Insert sample data into products
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(products) | products
Whitespace(0) |  
Special(() | (
Identifier(product_name) | product_name
Special(,) | ,
Whitespace(0) |  
Identifier(category_id) | category_id
Special(,) | ,
Whitespace(0) |  
Identifier(price) | price
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
StringLiteral(Smartphone) | 'Smartphone'
Special(,) | ,
Whitespace(0) |  
Numeric(1) | 1
Special(,) | ,
Whitespace(0) |  
Numeric(699.99) | 699.99
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Laptop) | 'Laptop'
Special(,) | ,
Whitespace(0) |  
Numeric(1) | 1
Special(,) | ,
Whitespace(0) |  
Numeric(999.99) | 999.99
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Novel) | 'Novel'
Special(,) | ,
Whitespace(0) |  
Numeric(2) | 2
Special(,) | ,
Whitespace(0) |  
Numeric(19.99) | 19.99
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(T-Shirt) | 'T-Shirt'
Special(,) | ,
Whitespace(0) |  
Numeric(3) | 3
Special(,) | ,
Whitespace(0) |  
Numeric(9.99) | 9.99
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Insert sample data into orders) | -- Insert sample data into orders
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(orders) | orders
Whitespace(0) |  
Special(() | (
Identifier(order_date) | order_date
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
StringLiteral(2023-03-01) | '2023-03-01'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(2023-03-05) | '2023-03-05'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Insert sample data into order_items) | -- Insert sample data into order_items
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(order_items) | order_items
Whitespace(0) |  
Special(() | (
Identifier(order_id) | order_id
Special(,) | ,
Whitespace(0) |  
Identifier(product_id) | product_id
Special(,) | ,
Whitespace(0) |  
Identifier(quantity) | quantity
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
Numeric(1) | 1
Special(,) | ,
Whitespace(0) |  
Numeric(1) | 1
Special(,) | ,
Whitespace(0) |  
Numeric(2) | 2
Special()) | )
Special(,) | ,
Whitespace(0) |  
Comment( 2 Smartphones) | -- 2 Smartphones
Whitespace(1) | 
    
Special(() | (
Numeric(1) | 1
Special(,) | ,
Whitespace(0) |  
Numeric(3) | 3
Special(,) | ,
Whitespace(0) |  
Numeric(1) | 1
Special()) | )
Special(,) | ,
Whitespace(0) |  
Comment( 1 Novel) | -- 1 Novel
Whitespace(1) | 
    
Special(() | (
Numeric(2) | 2
Special(,) | ,
Whitespace(0) |  
Numeric(2) | 2
Special(,) | ,
Whitespace(0) |  
Numeric(1) | 1
Special()) | )
Special(,) | ,
Whitespace(0) |  
Comment( 1 Laptop) | -- 1 Laptop
Whitespace(1) | 
    
Special(() | (
Numeric(2) | 2
Special(,) | ,
Whitespace(0) |  
Numeric(4) | 4
Special(,) | ,
Whitespace(0) |  
Numeric(3) | 3
Special()) | )
Special(;) | ;
Whitespace(0) |  
Comment( 3 T-Shirts) | -- 3 T-Shirts
Whitespace(2) | 


Comment( Complex query to get order summaries with total amounts) | -- Complex query to get order summaries with total amounts
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(o) | o
Special(.) | .
Identifier(order_id) | order_id
Special(,) | ,
Whitespace(1) | 
    
Identifier(o) | o
Special(.) | .
Identifier(order_date) | order_date
Special(,) | ,
Whitespace(1) | 
    
Identifier(SUM) | SUM
Special(() | (
Identifier(p) | p
Special(.) | .
Identifier(price) | price
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Identifier(oi) | oi
Special(.) | .
Identifier(quantity) | quantity
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(total_amount) | total_amount
Special(,) | ,
Whitespace(1) | 
    
Identifier(GROUP_CONCAT) | GROUP_CONCAT
Special(() | (
Identifier(p) | p
Special(.) | .
Identifier(product_name) | product_name
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
StringLiteral( x) | ' x'
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
Identifier(oi) | oi
Special(.) | .
Identifier(quantity) | quantity
Special(,) | ,
Whitespace(0) |  
StringLiteral(, ) | ', '
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(items_ordered) | items_ordered
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(orders) | orders
Whitespace(0) |  
Identifier(o) | o
Whitespace(1) | 
    
Keyword(INNER) | INNER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(order_items) | order_items
Whitespace(0) |  
Identifier(oi) | oi
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(o) | o
Special(.) | .
Identifier(order_id) | order_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(oi) | oi
Special(.) | .
Identifier(order_id) | order_id
Whitespace(1) | 
    
Keyword(INNER) | INNER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(products) | products
Whitespace(0) |  
Identifier(p) | p
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(oi) | oi
Special(.) | .
Identifier(product_id) | product_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(p) | p
Special(.) | .
Identifier(product_id) | product_id
Whitespace(1) | 

Keyword(GROUP) | GROUP
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
    
Identifier(o) | o
Special(.) | .
Identifier(order_id) | order_id
Special(,) | ,
Whitespace(1) | 
    
Identifier(o) | o
Special(.) | .
Identifier(order_date) | order_date
Whitespace(1) | 

Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
    
Identifier(o) | o
Special(.) | .
Identifier(order_date) | order_date
Special(;) | ;
Whitespace(2) | 


Comment( Subquery to find the top-selling category) | -- Subquery to find the top-selling category
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(c) | c
Special(.) | .
Identifier(category_name) | category_name
Special(,) | ,
Whitespace(1) | 
    
Identifier(SUM) | SUM
Special(() | (
Identifier(oi) | oi
Special(.) | .
Identifier(quantity) | quantity
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(total_quantity_sold) | total_quantity_sold
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(categories) | categories
Whitespace(0) |  
Identifier(c) | c
Whitespace(1) | 
    
Keyword(INNER) | INNER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(products) | products
Whitespace(0) |  
Identifier(p) | p
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(c) | c
Special(.) | .
Identifier(category_id) | category_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(p) | p
Special(.) | .
Identifier(category_id) | category_id
Whitespace(1) | 
    
Keyword(INNER) | INNER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(order_items) | order_items
Whitespace(0) |  
Identifier(oi) | oi
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(p) | p
Special(.) | .
Identifier(product_id) | product_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(oi) | oi
Special(.) | .
Identifier(product_id) | product_id
Whitespace(1) | 

Keyword(GROUP) | GROUP
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
    
Identifier(c) | c
Special(.) | .
Identifier(category_name) | category_name
Whitespace(1) | 

Keyword(HAVING) | HAVING
Whitespace(1) | 
    
Identifier(SUM) | SUM
Special(() | (
Identifier(oi) | oi
Special(.) | .
Identifier(quantity) | quantity
Special()) | )
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
        
Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(MAX) | MAX
Special(() | (
Identifier(total_quantity) | total_quantity
Special()) | )
Whitespace(1) | 
        
Keyword(FROM) | FROM
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
            
Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(SUM) | SUM
Special(() | (
Identifier(oi_inner) | oi_inner
Special(.) | .
Identifier(quantity) | quantity
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(total_quantity) | total_quantity
Whitespace(1) | 
            
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(categories) | categories
Whitespace(0) |  
Identifier(c_inner) | c_inner
Whitespace(1) | 
            
Keyword(INNER) | INNER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(products) | products
Whitespace(0) |  
Identifier(p_inner) | p_inner
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(c_inner) | c_inner
Special(.) | .
Identifier(category_id) | category_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(p_inner) | p_inner
Special(.) | .
Identifier(category_id) | category_id
Whitespace(1) | 
            
Keyword(INNER) | INNER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(order_items) | order_items
Whitespace(0) |  
Identifier(oi_inner) | oi_inner
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(p_inner) | p_inner
Special(.) | .
Identifier(product_id) | product_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(oi_inner) | oi_inner
Special(.) | .
Identifier(product_id) | product_id
Whitespace(1) | 
            
Keyword(GROUP) | GROUP
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(0) |  
Identifier(c_inner) | c_inner
Special(.) | .
Identifier(category_name) | category_name
Whitespace(1) | 
        
Special()) | )
Whitespace(1) | 
    
Special()) | )
Special(;) | ;
Whitespace(1) | 

