-- Deferred foreign key constraints.
-- Transactions with BEGIN TRANSACTION and COMMIT.
-- Ordering of inserts that rely on deferred constraint checking.
-- Use of PRAGMA statements.


PRAGMA foreign_keys = ON;

CREATE TABLE parent (
  id INTEGER PRIMARY KEY
);

CREATE TABLE child (
  id INTEGER PRIMARY KEY,
  parent_id INTEGER,
  FOREIGN KEY(parent_id) REFERENCES parent(id) DEFERRABLE INITIALLY DEFERRED
);

BEGIN TRANSACTION;
INSERT INTO child (id, parent_id) VALUES (1, 1);
INSERT INTO parent (id) VALUES (1);
COMMIT;
