Lexer result:

Comment( Table Creation and Data Insertion: An employees table is created to represent an organization's hierarchy, with a self-referencing foreign key manager_id.) | -- Table Creation and Data Insertion: An employees table is created to represent an organization's hierarchy, with a self-referencing foreign key manager_id.
Whitespace(1) | 

Comment( Recursive CTE: The org_chart CTE recursively traverses the employee hierarchy.) | -- Recursive CTE: The org_chart CTE recursively traverses the employee hierarchy.
Whitespace(1) | 

Comment( ) | -- 
Whitespace(1) | 

Comment(     Anchor Member: Selects the top-level employee (e.g., CEO) where manager_id is NULL.) | --     Anchor Member: Selects the top-level employee (e.g., CEO) where manager_id is NULL.
Whitespace(1) | 

Comment(     Recursive Member: Joins the employees table with the org_chart CTE to find direct reports.) | --     Recursive Member: Joins the employees table with the org_chart CTE to find direct reports.
Whitespace(1) | 

Comment( ) | -- 
Whitespace(1) | 

Comment( Final Selection: Outputs the hierarchical structure with indentation to represent different levels.) | -- Final Selection: Outputs the hierarchical structure with indentation to represent different levels.
Whitespace(3) | 



Comment( Create a table to store employee hierarchy) | -- Create a table to store employee hierarchy
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(employees) | employees
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(employee_id) | employee_id
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
    
Identifier(manager_id) | manager_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Special(,) | ,
Whitespace(0) |  
Comment( Self-referencing foreign key) | -- Self-referencing foreign key
Whitespace(1) | 
    
Keyword(FOREIGN) | FOREIGN
Whitespace(0) |  
Keyword(KEY) | KEY
Whitespace(0) |  
Special(() | (
Identifier(manager_id) | manager_id
Special()) | )
Whitespace(0) |  
Keyword(REFERENCES) | REFERENCES
Whitespace(0) |  
Identifier(employees) | employees
Special(() | (
Identifier(employee_id) | employee_id
Special()) | )
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Insert sample data into the employees table) | -- Insert sample data into the employees table
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(employees) | employees
Whitespace(0) |  
Special(() | (
Identifier(employee_id) | employee_id
Special(,) | ,
Whitespace(0) |  
Identifier(employee_name) | employee_name
Special(,) | ,
Whitespace(0) |  
Identifier(manager_id) | manager_id
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
Numeric(1) | 1
Special(,) | ,
Whitespace(0) |  
StringLiteral(CEO) | 'CEO'
Special(,) | ,
Whitespace(0) |  
Keyword(NULL) | NULL
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
Numeric(2) | 2
Special(,) | ,
Whitespace(0) |  
StringLiteral(VP of Sales) | 'VP of Sales'
Special(,) | ,
Whitespace(0) |  
Numeric(1) | 1
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
Numeric(3) | 3
Special(,) | ,
Whitespace(0) |  
StringLiteral(Sales Manager) | 'Sales Manager'
Special(,) | ,
Whitespace(0) |  
Numeric(2) | 2
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
Numeric(4) | 4
Special(,) | ,
Whitespace(0) |  
StringLiteral(Sales Associate) | 'Sales Associate'
Special(,) | ,
Whitespace(0) |  
Numeric(3) | 3
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
Numeric(5) | 5
Special(,) | ,
Whitespace(0) |  
StringLiteral(VP of Engineering) | 'VP of Engineering'
Special(,) | ,
Whitespace(0) |  
Numeric(1) | 1
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
Numeric(6) | 6
Special(,) | ,
Whitespace(0) |  
StringLiteral(Engineering Manager) | 'Engineering Manager'
Special(,) | ,
Whitespace(0) |  
Numeric(5) | 5
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
Numeric(7) | 7
Special(,) | ,
Whitespace(0) |  
StringLiteral(Engineer) | 'Engineer'
Special(,) | ,
Whitespace(0) |  
Numeric(6) | 6
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Use a Recursive CTE to traverse the employee hierarchy) | -- Use a Recursive CTE to traverse the employee hierarchy
Whitespace(1) | 

Keyword(WITH) | WITH
Whitespace(0) |  
Keyword(RECURSIVE) | RECURSIVE
Whitespace(0) |  
Identifier(org_chart) | org_chart
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Comment( Anchor member: select the top-level manager (CEO)) | -- Anchor member: select the top-level manager (CEO)
Whitespace(1) | 
    
Keyword(SELECT) | SELECT
Whitespace(1) | 
        
Identifier(employee_id) | employee_id
Special(,) | ,
Whitespace(1) | 
        
Identifier(employee_name) | employee_name
Special(,) | ,
Whitespace(1) | 
        
Identifier(manager_id) | manager_id
Special(,) | ,
Whitespace(1) | 
        
Numeric(1) | 1
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(level) | level
Whitespace(1) | 
    
Keyword(FROM) | FROM
Whitespace(1) | 
        
Identifier(employees) | employees
Whitespace(1) | 
    
Keyword(WHERE) | WHERE
Whitespace(1) | 
        
Identifier(manager_id) | manager_id
Whitespace(0) |  
Keyword(IS) | IS
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(2) | 

    
Keyword(UNION) | UNION
Whitespace(0) |  
Keyword(ALL) | ALL
Whitespace(2) | 

    
Comment( Recursive member: select employees reporting to the current level) | -- Recursive member: select employees reporting to the current level
Whitespace(1) | 
    
Keyword(SELECT) | SELECT
Whitespace(1) | 
        
Identifier(e) | e
Special(.) | .
Identifier(employee_id) | employee_id
Special(,) | ,
Whitespace(1) | 
        
Identifier(e) | e
Special(.) | .
Identifier(employee_name) | employee_name
Special(,) | ,
Whitespace(1) | 
        
Identifier(e) | e
Special(.) | .
Identifier(manager_id) | manager_id
Special(,) | ,
Whitespace(1) | 
        
Identifier(oc) | oc
Special(.) | .
Identifier(level) | level
Whitespace(0) |  
Operator(+) | +
Whitespace(0) |  
Numeric(1) | 1
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(level) | level
Whitespace(1) | 
    
Keyword(FROM) | FROM
Whitespace(1) | 
        
Identifier(employees) | employees
Whitespace(0) |  
Identifier(e) | e
Whitespace(1) | 
        
Keyword(INNER) | INNER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(org_chart) | org_chart
Whitespace(0) |  
Identifier(oc) | oc
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(e) | e
Special(.) | .
Identifier(manager_id) | manager_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(oc) | oc
Special(.) | .
Identifier(employee_id) | employee_id
Whitespace(1) | 

Special()) | )
Whitespace(2) | 


Comment( Select the hierarchical organization chart) | -- Select the hierarchical organization chart
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(employee_id) | employee_id
Special(,) | ,
Whitespace(1) | 
    
Identifier(employee_name) | employee_name
Special(,) | ,
Whitespace(1) | 
    
Identifier(manager_id) | manager_id
Special(,) | ,
Whitespace(1) | 
    
Identifier(level) | level
Special(,) | ,
Whitespace(1) | 
    
Comment( Indent employee names based on their level in the hierarchy) | -- Indent employee names based on their level in the hierarchy
Whitespace(1) | 
    
Keyword(REPLACE) | REPLACE
Special(() | (
Identifier(PRINTF) | PRINTF
Special(() | (
StringLiteral(%) | '%'
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
Special(() | (
Identifier(level) | level
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Numeric(4) | 4
Special()) | )
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
StringLiteral(s) | 's'
Special(,) | ,
Whitespace(0) |  
StringLiteral() | ''
Special()) | )
Special(,) | ,
Whitespace(0) |  
StringLiteral( ) | ' '
Special(,) | ,
Whitespace(0) |  
StringLiteral(    ) | '    '
Special()) | )
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
Identifier(employee_name) | employee_name
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(indented_name) | indented_name
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(org_chart) | org_chart
Whitespace(1) | 

Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
    
Identifier(level) | level
Special(,) | ,
Whitespace(1) | 
    
Identifier(manager_id) | manager_id
Special(;) | ;
Whitespace(1) | 

