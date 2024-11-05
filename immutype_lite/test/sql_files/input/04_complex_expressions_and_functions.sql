-- Subqueries within VALUES.
-- Use of built-in functions like AVG, ABS, and COALESCE.
-- Nested parentheses and expressions.
-- BETWEEN operator in WHERE clause.


-- This is a single-line comment
CREATE TABLE test_table (
  id INTEGER PRIMARY KEY, /* Inline comment */
  data TEXT
);

/*
This is a
multi-line comment
*/
INSERT INTO test_table (id, data) VALUES (1, 'Hello World'); -- End-of-line comment

INSERT INTO test_table (id, data) VALUES (2, 'It''s a sunny day');
