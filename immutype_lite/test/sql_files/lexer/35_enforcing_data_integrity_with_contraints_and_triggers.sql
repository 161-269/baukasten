Lexer result:

Comment( Tables Creation: Defines bank_accounts and transactions tables, enforcing data integrity with constraints.) | -- Tables Creation: Defines bank_accounts and transactions tables, enforcing data integrity with constraints.
Whitespace(1) | 

Comment( Trigger Definition: The trigger update_balance_after_transaction automatically updates the account balance after each transaction and checks for negative balances.) | -- Trigger Definition: The trigger update_balance_after_transaction automatically updates the account balance after each transaction and checks for negative balances.
Whitespace(1) | 

Comment( Transaction Processing: Inserts transactions to simulate withdrawals, with one transaction intended to fail due to insufficient funds.) | -- Transaction Processing: Inserts transactions to simulate withdrawals, with one transaction intended to fail due to insufficient funds.
Whitespace(1) | 

Comment( Error Handling: Uses RAISE(ABORT, ...) within the trigger to prevent negative balances and rollback the transaction if necessary.) | -- Error Handling: Uses RAISE(ABORT, ...) within the trigger to prevent negative balances and rollback the transaction if necessary.
Whitespace(3) | 



Comment( Create a table for bank accounts) | -- Create a table for bank accounts
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(bank_accounts) | bank_accounts
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(account_id) | account_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
    
Identifier(account_holder) | account_holder
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Identifier(balance) | balance
Whitespace(0) |  
Keyword(REAL) | REAL
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(0) |  
Keyword(CHECK) | CHECK
Whitespace(0) |  
Special(() | (
Identifier(balance) | balance
Whitespace(0) |  
Operator(>=) | >=
Whitespace(0) |  
Identifier(0) | 0
Special()) | )
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Create a table for transactions) | -- Create a table for transactions
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Identifier(transactions) | transactions
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(transaction_id) | transaction_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
    
Identifier(account_id) | account_id
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Identifier(amount) | amount
Whitespace(0) |  
Keyword(REAL) | REAL
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
    
Identifier(transaction_date) | transaction_date
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
Identifier(account_id) | account_id
Special()) | )
Whitespace(0) |  
Keyword(REFERENCES) | REFERENCES
Whitespace(0) |  
Identifier(bank_accounts) | bank_accounts
Special(() | (
Identifier(account_id) | account_id
Special()) | )
Whitespace(1) | 

Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Create a trigger to update account balance after a transaction) | -- Create a trigger to update account balance after a transaction
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TRIGGER) | TRIGGER
Whitespace(0) |  
Identifier(update_balance_after_transaction) | update_balance_after_transaction
Whitespace(1) | 

Keyword(AFTER) | AFTER
Whitespace(0) |  
Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(transactions) | transactions
Whitespace(1) | 

Keyword(BEGIN) | BEGIN
Whitespace(1) | 
    
Keyword(UPDATE) | UPDATE
Whitespace(0) |  
Identifier(bank_accounts) | bank_accounts
Whitespace(1) | 
    
Keyword(SET) | SET
Whitespace(0) |  
Identifier(balance) | balance
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(balance) | balance
Whitespace(0) |  
Operator(+) | +
Whitespace(0) |  
Identifier(NEW) | NEW
Special(.) | .
Identifier(amount) | amount
Whitespace(1) | 
    
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(account_id) | account_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(NEW) | NEW
Special(.) | .
Identifier(account_id) | account_id
Special(;) | ;
Whitespace(2) | 

    
Comment( Ensure the account balance does not go negative) | -- Ensure the account balance does not go negative
Whitespace(1) | 
    
Keyword(SELECT) | SELECT
Whitespace(0) |  
Keyword(CASE) | CASE
Whitespace(1) | 
        
Keyword(WHEN) | WHEN
Whitespace(0) |  
Special(() | (
Keyword(SELECT) | SELECT
Whitespace(0) |  
Identifier(balance) | balance
Whitespace(0) |  
Keyword(FROM) | FROM
Whitespace(0) |  
Identifier(bank_accounts) | bank_accounts
Whitespace(0) |  
Keyword(WHERE) | WHERE
Whitespace(0) |  
Identifier(account_id) | account_id
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(NEW) | NEW
Special(.) | .
Identifier(account_id) | account_id
Special()) | )
Whitespace(0) |  
Operator(<) | <
Whitespace(0) |  
Identifier(0) | 0
Whitespace(1) | 
        
Keyword(THEN) | THEN
Whitespace(0) |  
Keyword(RAISE) | RAISE
Special(() | (
Keyword(ABORT) | ABORT
Special(,) | ,
Whitespace(0) |  
StringLiteral(Insufficient funds in account_id ) | 'Insufficient funds in account_id '
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
Identifier(NEW) | NEW
Special(.) | .
Identifier(account_id) | account_id
Special()) | )
Whitespace(1) | 
    
Keyword(END) | END
Special(;) | ;
Whitespace(1) | 

Keyword(END) | END
Special(;) | ;
Whitespace(2) | 


Comment( Insert sample data into bank_accounts) | -- Insert sample data into bank_accounts
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(bank_accounts) | bank_accounts
Whitespace(0) |  
Special(() | (
Identifier(account_holder) | account_holder
Special(,) | ,
Whitespace(0) |  
Identifier(balance) | balance
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
StringLiteral(Alice) | 'Alice'
Special(,) | ,
Whitespace(0) |  
Identifier(1000) | 1000
Special(.) | .
Identifier(00) | 00
Special()) | )
Special(,) | ,
Whitespace(1) | 
    
Special(() | (
StringLiteral(Bob) | 'Bob'
Special(,) | ,
Whitespace(0) |  
Identifier(500) | 500
Special(.) | .
Identifier(00) | 00
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Begin a transaction to process a withdrawal) | -- Begin a transaction to process a withdrawal
Whitespace(1) | 

Keyword(BEGIN) | BEGIN
Whitespace(0) |  
Keyword(TRANSACTION) | TRANSACTION
Special(;) | ;
Whitespace(2) | 


Comment( Attempt to withdraw $200 from Alice's account) | -- Attempt to withdraw $200 from Alice's account
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(transactions) | transactions
Whitespace(0) |  
Special(() | (
Identifier(account_id) | account_id
Special(,) | ,
Whitespace(0) |  
Identifier(amount) | amount
Special(,) | ,
Whitespace(0) |  
Identifier(transaction_date) | transaction_date
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
Identifier(1) | 1
Special(,) | ,
Whitespace(0) |  
Operator(-) | -
Identifier(200) | 200
Special(.) | .
Identifier(00) | 00
Special(,) | ,
Whitespace(0) |  
Identifier(DATE) | DATE
Special(() | (
StringLiteral(now) | 'now'
Special()) | )
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Attempt to withdraw $600 from Bob's account (should fail)) | -- Attempt to withdraw $600 from Bob's account (should fail)
Whitespace(1) | 

Keyword(INSERT) | INSERT
Whitespace(0) |  
Keyword(INTO) | INTO
Whitespace(0) |  
Identifier(transactions) | transactions
Whitespace(0) |  
Special(() | (
Identifier(account_id) | account_id
Special(,) | ,
Whitespace(0) |  
Identifier(amount) | amount
Special(,) | ,
Whitespace(0) |  
Identifier(transaction_date) | transaction_date
Special()) | )
Whitespace(0) |  
Keyword(VALUES) | VALUES
Whitespace(1) | 
    
Special(() | (
Identifier(2) | 2
Special(,) | ,
Whitespace(0) |  
Operator(-) | -
Identifier(600) | 600
Special(.) | .
Identifier(00) | 00
Special(,) | ,
Whitespace(0) |  
Identifier(DATE) | DATE
Special(() | (
StringLiteral(now) | 'now'
Special()) | )
Special()) | )
Special(;) | ;
Whitespace(2) | 


Comment( Commit the transaction) | -- Commit the transaction
Whitespace(1) | 

Keyword(COMMIT) | COMMIT
Special(;) | ;
Whitespace(2) | 


Comment( Select the final account balances) | -- Select the final account balances
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
    
Identifier(account_id) | account_id
Special(,) | ,
Whitespace(1) | 
    
Identifier(account_holder) | account_holder
Special(,) | ,
Whitespace(1) | 
    
Identifier(balance) | balance
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
    
Identifier(bank_accounts) | bank_accounts
Special(;) | ;
Whitespace(1) | 

