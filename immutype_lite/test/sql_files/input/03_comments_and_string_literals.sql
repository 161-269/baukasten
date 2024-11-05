-- Single-line (--) and multi-line (/* */) comments.
-- Inline comments within statements.
-- String literals containing escaped characters.
-- Comments placed at various points in the code.


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
