Lexer result:

Comment( Role-Based Access Control (RBAC) Implementation:) | -- Role-Based Access Control (RBAC) Implementation:
Whitespace(1) | 

Comment( ) | -- 
Whitespace(1) | 

Comment(     Defines roles, users, permissions, and role_permissions tables to manage access control.) | --     Defines roles, users, permissions, and role_permissions tables to manage access control.
Whitespace(1) | 

Comment( ) | -- 
Whitespace(1) | 

Comment( Data Insertion: Adds sample roles, users, permissions, and assigns permissions to roles.) | -- Data Insertion: Adds sample roles, users, permissions, and assigns permissions to roles.
Whitespace(1) | 

Comment( Permission Queries:) | -- Permission Queries:
Whitespace(1) | 

Comment( ) | -- 
Whitespace(1) | 

Comment(     Retrieves permissions for a specific user.) | --     Retrieves permissions for a specific user.
Whitespace(1) | 

Comment(     Lists all users along with their roles and permissions.) | --     Lists all users along with their roles and permissions.
Whitespace(1) | 

Comment( ) | -- 
Whitespace(1) | 

Comment( Best Practices:) | -- Best Practices:
Whitespace(1) | 

Comment( ) | -- 
Whitespace(1) | 

Comment(     Uses normalized tables to avoid data redundancy.) | --     Uses normalized tables to avoid data redundancy.
Whitespace(1) | 

Comment(     Employs GROUP_CONCAT to aggregate permissions per user.) | --     Employs GROUP_CONCAT to aggregate permissions per user.
Whitespace(3) | 



Comment( Create tables for users and roles) | -- Create tables for users and roles
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(roles) | roles
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(role_id) | role_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
    
Identifier(role_name) | role_name
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(UNIQUE) | UNIQUE
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(users) | users
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
    
Identifier(role_id) | role_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
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
Identifier(role_id) | role_id
Special()) | )
Whitespace(0) |  
Keyword(REFERENCES) | REFERENCES
Whitespace(0) |  
Identifier(roles) | roles
Special(() | (
Identifier(role_id) | role_id
Special()) | )
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(permissions) | permissions
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(permission_id) | permission_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
    
Identifier(permission_name) | permission_name
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(UNIQUE) | UNIQUE
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(role_permissions) | role_permissions
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(role_id) | role_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Identifier(permission_id) | permission_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Whitespace(0) |  
Special(() | (
Identifier(role_id) | role_id
Special(,) | ,
Whitespace(0) |  
Identifier(permission_id) | permission_id
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Keyword(FOREIGN) | FOREIGN
Whitespace(0) |  
Keyword(KEY) | KEY
Whitespace(0) |  
Special(() | (
Identifier(role_id) | role_id
Special()) | )
Whitespace(0) |  
Keyword(REFERENCES) | REFERENCES
Whitespace(0) |  
Identifier(roles) | roles
Special(() | (
Identifier(role_id) | role_id
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Keyword(FOREIGN) | FOREIGN
Whitespace(0) |  
Keyword(KEY) | KEY
Whitespace(0) |  
Special(() | (
Identifier(permission_id) | permission_id
Special()) | )
Whitespace(0) |  
Keyword(REFERENCES) | REFERENCES
Whitespace(0) |  
Identifier(permissions) | permissions
Special(() | (
Identifier(permission_id) | permission_id
Special()) | )
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Insert sample data into roles) | -- Insert sample data into roles
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(roles) | roles
Whitespace(0) |  
Special(() | (
Identifier(role_name) | role_name
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
StringLiteral(Admin) | 'Admin'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Editor) | 'Editor'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Viewer) | 'Viewer'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Insert sample data into users) | -- Insert sample data into users
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(users) | users
Whitespace(0) |  
Special(() | (
Identifier(username) | username
Special(,) | ,
Whitespace(0) |  
Identifier(role_id) | role_id
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
StringLiteral(admin_user) | 'admin_user'
Special(,) | ,
Whitespace(0) |  
Identifier(1) | 1
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(editor_user) | 'editor_user'
Special(,) | ,
Whitespace(0) |  
Identifier(2) | 2
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(viewer_user) | 'viewer_user'
Special(,) | ,
Whitespace(0) |  
Identifier(3) | 3
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Insert sample data into permissions) | -- Insert sample data into permissions
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(permissions) | permissions
Whitespace(0) |  
Special(() | (
Identifier(permission_name) | permission_name
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
StringLiteral(Create) | 'Create'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Read) | 'Read'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Update) | 'Update'
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Delete) | 'Delete'
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Assign permissions to roles) | -- Assign permissions to roles
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(role_permissions) | role_permissions
Whitespace(0) |  
Special(() | (
Identifier(role_id) | role_id
Special(,) | ,
Whitespace(0) |  
Identifier(permission_id) | permission_id
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
Identifier(1) | 1
Special()) | )
Special(,) | ,
Whitespace(0) |  
Comment( Admin has Create) | -- Admin has Create
Whitespace(1) | 
    
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
Identifier(2) | 2
Special()) | )
Special(,) | ,
Whitespace(0) |  
Comment( Admin has Read) | -- Admin has Read
Whitespace(1) | 
    
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
Identifier(3) | 3
Special()) | )
Special(,) | ,
Whitespace(0) |  
Comment( Admin has Update) | -- Admin has Update
Whitespace(1) | 
    
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
Identifier(4) | 4
Special()) | )
Special(,) | ,
Whitespace(0) |  
Comment( Admin has Delete) | -- Admin has Delete
Whitespace(1) | 
    
Special(() | (
Identifier(2) | 2
Special(,) | ,
Whitespace(0) |  
Identifier(2) | 2
Special()) | )
Special(,) | ,
Whitespace(0) |  
Comment( Editor has Read) | -- Editor has Read
Whitespace(1) | 
    
Special(() | (
Identifier(2) | 2
Special(,) | ,
Whitespace(0) |  
Identifier(3) | 3
Special()) | )
Special(,) | ,
Whitespace(0) |  
Comment( Editor has Update) | -- Editor has Update
Whitespace(1) | 
    
Special(() | (
Identifier(3) | 3
Special(,) | ,
Whitespace(0) |  
Identifier(2) | 2
Special()) | )
Special(;) | ;
Whitespace(0) |  
Comment( Viewer has Read) | -- Viewer has Read
Whitespace(2) | 


Comment( Query to get permissions of a specific user) | -- Query to get permissions of a specific user
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(u) | u
Special(.) | .
Identifier(username) | username
Special(,) | ,
Whitespace(1) | 
    
Identifier(r) | r
Special(.) | .
Identifier(role_name) | role_name
Special(,) | ,
Whitespace(1) | 
    
Identifier(GROUP_CONCAT) | GROUP_CONCAT
Special(() | (
Identifier(p) | p
Special(.) | .
Identifier(permission_name) | permission_name
Special(,) | ,
Whitespace(0) |  
StringLiteral(, ) | ', '
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(permissions) | permissions
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(users) | users
Whitespace(0) |  
Identifier(u) | u
Whitespace(1) | 
    
Keyword(INNER) | INNER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(roles) | roles
Whitespace(0) |  
Identifier(r) | r
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(u) | u
Special(.) | .
Identifier(role_id) | role_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(r) | r
Special(.) | .
Identifier(role_id) | role_id
Whitespace(1) | 
    
Keyword(INNER) | INNER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(role_permissions) | role_permissions
Whitespace(0) |  
Identifier(rp) | rp
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(r) | r
Special(.) | .
Identifier(role_id) | role_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(rp) | rp
Special(.) | .
Identifier(role_id) | role_id
Whitespace(1) | 
    
Keyword(INNER) | INNER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(permissions) | permissions
Whitespace(0) |  
Identifier(p) | p
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(rp) | rp
Special(.) | .
Identifier(permission_id) | permission_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(p) | p
Special(.) | .
Identifier(permission_id) | permission_id
Whitespace(1) | 

Keyword(WHERE) | WHERE
Whitespace(1) | 
    
Identifier(u) | u
Special(.) | .
Identifier(username) | username
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
StringLiteral(editor_user) | 'editor_user'
Whitespace(1) | 

Keyword(GROUP) | GROUP
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
    
Identifier(u) | u
Special(.) | .
Identifier(username) | username
Special(,) | ,
Whitespace(1) | 
    
Identifier(r) | r
Special(.) | .
Identifier(role_name) | role_name
Special(;) | ;
Whitespace(2) | 


Comment( View all users and their permissions) | -- View all users and their permissions
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(u) | u
Special(.) | .
Identifier(username) | username
Special(,) | ,
Whitespace(1) | 
    
Identifier(r) | r
Special(.) | .
Identifier(role_name) | role_name
Special(,) | ,
Whitespace(1) | 
    
Identifier(GROUP_CONCAT) | GROUP_CONCAT
Special(() | (
Identifier(p) | p
Special(.) | .
Identifier(permission_name) | permission_name
Special(,) | ,
Whitespace(0) |  
StringLiteral(, ) | ', '
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(permissions) | permissions
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(users) | users
Whitespace(0) |  
Identifier(u) | u
Whitespace(1) | 
    
Keyword(INNER) | INNER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(roles) | roles
Whitespace(0) |  
Identifier(r) | r
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(u) | u
Special(.) | .
Identifier(role_id) | role_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(r) | r
Special(.) | .
Identifier(role_id) | role_id
Whitespace(1) | 
    
Keyword(INNER) | INNER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(role_permissions) | role_permissions
Whitespace(0) |  
Identifier(rp) | rp
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(r) | r
Special(.) | .
Identifier(role_id) | role_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(rp) | rp
Special(.) | .
Identifier(role_id) | role_id
Whitespace(1) | 
    
Keyword(INNER) | INNER
Whitespace(0) |  
Keyword(JOIN) | JOIN
Whitespace(0) |  
Identifier(permissions) | permissions
Whitespace(0) |  
Identifier(p) | p
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(rp) | rp
Special(.) | .
Identifier(permission_id) | permission_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(p) | p
Special(.) | .
Identifier(permission_id) | permission_id
Whitespace(1) | 

Keyword(GROUP) | GROUP
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
    
Identifier(u) | u
Special(.) | .
Identifier(username) | username
Special(,) | ,
Whitespace(1) | 
    
Identifier(r) | r
Special(.) | .
Identifier(role_name) | role_name
Whitespace(1) | 

Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
    
Identifier(u) | u
Special(.) | .
Identifier(username) | username
Special(;) | ;
Whitespace(1) | 

