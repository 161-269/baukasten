-- ON CONFLICT DO UPDATE (UPSERT) syntax.
-- Using excluded table alias in updates.
-- String concatenation in update statements.


CREATE TABLE upsert_test (
  id INTEGER PRIMARY KEY,
  value TEXT
);

INSERT INTO upsert_test (id, value) VALUES (1, 'Initial Value');

INSERT INTO upsert_test (id, value) VALUES (1, 'Updated Value')
  ON CONFLICT(id) DO UPDATE SET value = excluded.value || ' (Upserted)';

SELECT * FROM upsert_test;
