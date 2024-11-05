Lexer error:
test/sql_files/input/21_upsert_clauses_and_conflict_resolution.sql:14:56

-- ON CONFLICT DO UPDATE (UPSERT) syntax.
-- Using excluded table alias in updates.
-- String concatenation in update statements.


CREATE TABLE upsert_test (
  id INTEGER PRIMARY KEY,
  value TEXT
);

INSERT INTO upsert_test (id, value) VALUES (1, 'Initial Value');

INSERT INTO upsert_test (id, value) VALUES (1, 'Updated Value')
  ON CONFLICT(id) DO UPDATE SET value = excluded.value 

Lexer error begins here:
v
|| ' (Upserted)';

SELECT * FROM upsert_test;
