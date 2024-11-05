Lexer result:

Comment( Table Creation and Data Insertion: A table employee_sales is created to store sales data per employee, including their name, region, sales amount, and date.) | -- Table Creation and Data Insertion: A table employee_sales is created to store sales data per employee, including their name, region, sales amount, and date.
Whitespace(1) | 

Comment( Common Table Expression (CTE): The CTE cumulative_sales calculates the cumulative sales for each employee using window functions.) | -- Common Table Expression (CTE): The CTE cumulative_sales calculates the cumulative sales for each employee using window functions.
Whitespace(1) | 

Comment( ) | -- 
Whitespace(1) | 

Comment(     SUM(sales_amount) OVER (...) computes the running total of sales per employee over time.) | --     SUM(sales_amount) OVER (...) computes the running total of sales per employee over time.
Whitespace(1) | 

Comment(     RANK() OVER (...) assigns a rank to each sale amount per employee.) | --     RANK() OVER (...) assigns a rank to each sale amount per employee.
Whitespace(1) | 

Comment( ) | -- 
Whitespace(1) | 

Comment( Final Selection: The main query selects data from the CTE, providing a detailed view of each sale, cumulative sales to date, and the rank of each sale amount per employee.) | -- Final Selection: The main query selects data from the CTE, providing a detailed view of each sale, cumulative sales to date, and the rank of each sale amount per employee.
Whitespace(3) | 



Comment( Create a table to store employee sales data) | -- Create a table to store employee sales data
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(employee_sales) | employee_sales
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
    
Identifier(employee_name) | employee_name
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Identifier(region) | region
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Identifier(sales_amount) | sales_amount
Whitespace(0) |  
Keyword(REAL) | REAL
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Identifier(sales_date) | sales_date
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


Comment( Insert sample data into the employee_sales table) | -- Insert sample data into the employee_sales table
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(employee_sales) | employee_sales
Whitespace(0) |  
Special(() | (
Identifier(employee_name) | employee_name
Special(,) | ,
Whitespace(0) |  
Identifier(region) | region
Special(,) | ,
Whitespace(0) |  
Identifier(sales_amount) | sales_amount
Special(,) | ,
Whitespace(0) |  
Identifier(sales_date) | sales_date
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
StringLiteral(Alice) | 'Alice'
Special(,) | ,
Whitespace(0) |  
StringLiteral(North) | 'North'
Special(,) | ,
Whitespace(0) |  
Numeric(5.0e3) | 5000.00
Special(,) | ,
Whitespace(0) |  
StringLiteral(2023-01-15) | '2023-01-15'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Bob) | 'Bob'
Special(,) | ,
Whitespace(0) |  
StringLiteral(South) | 'South'
Special(,) | ,
Whitespace(0) |  
Numeric(7.0e3) | 7000.00
Special(,) | ,
Whitespace(0) |  
StringLiteral(2023-01-20) | '2023-01-20'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Alice) | 'Alice'
Special(,) | ,
Whitespace(0) |  
StringLiteral(North) | 'North'
Special(,) | ,
Whitespace(0) |  
Numeric(8.0e3) | 8000.00
Special(,) | ,
Whitespace(0) |  
StringLiteral(2023-02-10) | '2023-02-10'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Charlie) | 'Charlie'
Special(,) | ,
Whitespace(0) |  
StringLiteral(East) | 'East'
Special(,) | ,
Whitespace(0) |  
Numeric(6.0e3) | 6000.00
Special(,) | ,
Whitespace(0) |  
StringLiteral(2023-02-15) | '2023-02-15'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Bob) | 'Bob'
Special(,) | ,
Whitespace(0) |  
StringLiteral(South) | 'South'
Special(,) | ,
Whitespace(0) |  
Numeric(4.0e3) | 4000.00
Special(,) | ,
Whitespace(0) |  
StringLiteral(2023-03-05) | '2023-03-05'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Charlie) | 'Charlie'
Special(,) | ,
Whitespace(0) |  
StringLiteral(East) | 'East'
Special(,) | ,
Whitespace(0) |  
Numeric(7.0e3) | 7000.00
Special(,) | ,
Whitespace(0) |  
StringLiteral(2023-03-10) | '2023-03-10'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Use a Common Table Expression (CTE) and window functions to calculate cumulative sales per employee) | -- Use a Common Table Expression (CTE) and window functions to calculate cumulative sales per employee
Whitespace(1) | 

Keyword(WITH) | WITH
Whitespace(0) |  
Identifier(cumulative_sales) | cumulative_sales
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Keyword(SELECT) | SELECT
Whitespace(1) | 
        
Identifier(employee_name) | employee_name
Special(,) | ,
Whitespace(1) | 
        
Identifier(region) | region
Special(,) | ,
Whitespace(1) | 
        
Identifier(sales_amount) | sales_amount
Special(,) | ,
Whitespace(1) | 
        
Identifier(sales_date) | sales_date
Special(,) | ,
Whitespace(1) | 
        
Identifier(SUM) | SUM
Special(() | (
Identifier(sales_amount) | sales_amount
Special()) | )
Whitespace(0) |  
Keyword(OVER) | OVER
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
            
Keyword(PARTITION) | PARTITION
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(0) |  
Identifier(employee_name) | employee_name
Whitespace(1) | 
            
Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(0) |  
Identifier(sales_date) | sales_date
Whitespace(1) | 
            
Keyword(ROWS) | ROWS
Whitespace(0) |  
Keyword(BETWEEN) | BETWEEN
Whitespace(0) |  
Keyword(UNBOUNDED) | UNBOUNDED
Whitespace(0) |  
Keyword(PRECEDING) | PRECEDING
Whitespace(0) |  
Keyword(AND) | AND
Whitespace(0) |  
Keyword(CURRENT) | CURRENT
Whitespace(0) |  
Keyword(ROW) | ROW
Whitespace(1) | 
        
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(total_sales_to_date) | total_sales_to_date
Special(,) | ,
Whitespace(1) | 
        
Identifier(RANK) | RANK
Special(() | (
Special()) | )
Whitespace(0) |  
Keyword(OVER) | OVER
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
            
Keyword(PARTITION) | PARTITION
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(0) |  
Identifier(employee_name) | employee_name
Whitespace(1) | 
            
Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(0) |  
Identifier(sales_amount) | sales_amount
Whitespace(0) |  
Keyword(DESC) | DESC
Whitespace(1) | 
        
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(sales_rank) | sales_rank
Whitespace(1) | 
    
Keyword(FROM) | FROM
Whitespace(1) | 
        
Identifier(employee_sales) | employee_sales
Whitespace(1) | 

Special()) | )
Whitespace(2) | 


Comment( Select employee cumulative sales and their sales rank) | -- Select employee cumulative sales and their sales rank
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(employee_name) | employee_name
Special(,) | ,
Whitespace(1) | 
    
Identifier(region) | region
Special(,) | ,
Whitespace(1) | 
    
Identifier(sales_amount) | sales_amount
Special(,) | ,
Whitespace(1) | 
    
Identifier(sales_date) | sales_date
Special(,) | ,
Whitespace(1) | 
    
Identifier(total_sales_to_date) | total_sales_to_date
Special(,) | ,
Whitespace(1) | 
    
Identifier(sales_rank) | sales_rank
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(cumulative_sales) | cumulative_sales
Whitespace(1) | 

Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
    
Identifier(employee_name) | employee_name
Special(,) | ,
Whitespace(1) | 
    
Identifier(sales_date) | sales_date
Special(;) | ;
Whitespace(1) | 

