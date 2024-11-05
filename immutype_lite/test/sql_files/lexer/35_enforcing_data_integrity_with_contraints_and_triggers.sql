Lexer error:
test/sql_files/input/35_enforcing_data_integrity_with_contraints_and_triggers.sql:11:42

-- Tables Creation: Defines bank_accounts and transactions tables, enforcing data integrity with constraints.
-- Trigger Definition: The trigger update_balance_after_transaction automatically updates the account balance after each transaction and checks for negative balances.
-- Transaction Processing: Inserts transactions to simulate withdrawals, with one transaction intended to fail due to insufficient funds.
-- Error Handling: Uses RAISE(ABORT, ...) within the trigger to prevent negative balances and rollback the transaction if necessary.


-- Create a table for bank accounts
CREATE TABLE bank_accounts (
    account_id INTEGER PRIMARY KEY,
    account_holder TEXT NOT NULL,
    balance REAL NOT NULL CHECK (balance 

Lexer error begins here:
v
>= 0)
);

-- Create a table for transactions
CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY,
    account_id INTEGER NOT NULL,
    amount REAL NOT NULL,
    transaction_date DATE NOT NULL,
    FOREIGN KEY (account_id) REFERENCES bank_accounts(account_id)
);

-- Create a trigger to update account balance after a transaction
CREATE TRIGGER update_balance_after_transaction
AFTER INSERT ON transactions
BEGIN
    UPDATE bank_accounts
    SET balance = balance + NEW.amount
    WHERE account_id = NEW.account_id;

    -- Ensure the account balance does not go negative
    SELECT CASE
        WHEN (SELECT balance FROM bank_accounts WHERE account_id = NEW.account_id) < 0
        THEN RAISE(ABORT, 'Insufficient funds in account_id ' || NEW.account_id)
    END;
END;

-- Insert sample data into bank_accounts
INSERT INTO bank_accounts (account_holder, balance) VALUES
    ('Alice', 1000.00),
    ('Bob', 500.00);

-- Begin a transaction to process a withdrawal
BEGIN TRANSACTION;

-- Attempt to withdraw $200 from Alice's account
INSERT INTO transactions (account_id, amount, transaction_date) VALUES
    (1, -200.00, DATE('now'));

-- Attempt to withdraw $600 from Bob's account (should fail)
INSERT INTO transactions (account_id, amount, transaction_date) VALUES
    (2, -600.00, DATE('now'));

-- Commit the transaction
COMMIT;

-- Select the final account balances
SELECT
    account_id,
    account_holder,
    balance
FROM
    bank_accounts;
