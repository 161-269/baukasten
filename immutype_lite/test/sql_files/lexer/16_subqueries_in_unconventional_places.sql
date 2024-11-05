Lexer error:
test/sql_files/input/16_subqueries_in_unconventional_places.sql:14:52

-- Subqueries in SET and WHERE clauses within UPDATE.
-- Multiple subqueries in a single statement.
-- Parser's ability to handle nested queries.


CREATE TABLE subquery_test (
  id INTEGER PRIMARY KEY,
  value INTEGER
);

INSERT INTO subquery_test (id, value) VALUES (1, 10), (2, 20);

UPDATE subquery_test
SET value = (SELECT MAX(value) FROM subquery_test) 

Lexer error begins here:
v
+ (SELECT COUNT(*) FROM subquery_test)
WHERE id = (SELECT MIN(id) FROM subquery_test);
