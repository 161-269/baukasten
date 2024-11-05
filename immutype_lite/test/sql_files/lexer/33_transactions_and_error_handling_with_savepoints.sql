Lexer error:
test/sql_files/input/33_transactions_and_error_handling_with_savepoints.sql:11:47

-- Transaction Management: Uses transactions and savepoints to ensure atomicity of multiple operations.
-- Inventory Update and Order Insertion: Updates inventory quantities and inserts corresponding orders.
-- Error Checking with RAISE(ABORT): Checks for negative inventory quantities and aborts the transaction if detected.
-- Exception Handling: If an error occurs, rolls back to the savepoint and commits the transaction to release locks.


-- Create tables for orders and inventory
CREATE TABLE inventory (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity 

Lexer error begins here:
v
>= 0)
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    product_id INTEGER NOT NULL,
    order_quantity INTEGER NOT NULL CHECK (order_quantity > 0),
    order_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES inventory(product_id)
);

-- Insert sample data into inventory
INSERT INTO inventory (product_id, product_name, quantity) VALUES
    (101, 'Widget', 50),
    (102, 'Gadget', 75),
    (103, 'Thingamajig', 100);

-- Begin a transaction to process multiple orders atomically
BEGIN TRANSACTION;

-- Set a savepoint in case we need to roll back to this point
SAVEPOINT order_processing;

-- Attempt to process an order for Widgets
UPDATE inventory
SET quantity = quantity - 20
WHERE product_id = 101;

INSERT INTO orders (product_id, order_quantity, order_date) VALUES
    (101, 20, DATE('now'));

-- Check if inventory quantity went negative
SELECT CASE
    WHEN quantity < 0 THEN RAISE(ABORT, 'Insufficient inventory for product_id 101')
END
FROM inventory
WHERE product_id = 101;

-- Attempt to process an order for Gadgets
UPDATE inventory
SET quantity = quantity - 80
WHERE product_id = 102;

INSERT INTO orders (product_id, order_quantity, order_date) VALUES
    (102, 80, DATE('now'));

-- Check if inventory quantity went negative
SELECT CASE
    WHEN quantity < 0 THEN RAISE(ABORT, 'Insufficient inventory for product_id 102')
END
FROM inventory
WHERE product_id = 102;

-- Commit the transaction if all operations succeeded
RELEASE SAVEPOINT order_processing;
COMMIT;

-- Exception handling: Roll back to savepoint if an error occurred
ROLLBACK TO order_processing;
COMMIT;
