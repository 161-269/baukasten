-- Difference between IS NULL and = NULL.
-- Understanding SQLite's handling of NULL comparisons.
-- Parser's interpretation of NULL in expressions.


CREATE TABLE null_test (
  id INTEGER,
  value TEXT
);

INSERT INTO null_test (id, value) VALUES (1, NULL), (2, 'Not Null');

SELECT * FROM null_test WHERE value IS NULL;

SELECT * FROM null_test WHERE value = NULL;
