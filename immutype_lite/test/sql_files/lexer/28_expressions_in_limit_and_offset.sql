Lexer error:
test/sql_files/input/28_expressions_in_limit_and_offset.sql:13:80

-- Using subqueries and expressions in LIMIT and OFFSET.
-- Dynamic pagination based on table data.
-- Parser's handling of expressions in these clauses.


CREATE TABLE limit_offset_test (
  id INTEGER PRIMARY KEY,
  value TEXT
);

INSERT INTO limit_offset_test (value) VALUES ('Row1'), ('Row2'), ('Row3'), ('Row4');

SELECT * FROM limit_offset_test LIMIT (SELECT COUNT(*) FROM limit_offset_test) 

Lexer error begins here:
v
- 2 OFFSET 1;
