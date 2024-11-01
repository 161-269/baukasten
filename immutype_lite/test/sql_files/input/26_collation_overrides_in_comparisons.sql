-- Overriding default collation in WHERE clause.
-- Mixing different collations in queries.
-- Parser's handling of collation precedence.


CREATE TABLE collate_override (
  value TEXT COLLATE BINARY
);

INSERT INTO collate_override (value) VALUES ('apple'), ('Apple');

SELECT * FROM collate_override WHERE value = 'APPLE' COLLATE NOCASE;
