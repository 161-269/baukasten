-- Using SAVEPOINT and ROLLBACK TO for nested transactions.
-- Transactions within transactions.
-- Parser's handling of transaction control flow.


BEGIN TRANSACTION;
INSERT INTO data (value) VALUES ('Outer Transaction');

SAVEPOINT inner_savepoint;
INSERT INTO data (value) VALUES ('Inner Transaction');
ROLLBACK TO inner_savepoint;

INSERT INTO data (value) VALUES ('After Rollback');
COMMIT;
