-- Specifying different collation sequences in ORDER BY.
-- Overriding column collation in queries.
-- Parser handling of collation specifications.


CREATE TABLE collation_test (
  value TEXT COLLATE NOCASE
);

INSERT INTO collation_test (value) VALUES ('a'), ('A');

SELECT * FROM collation_test ORDER BY value COLLATE RTRIM;
