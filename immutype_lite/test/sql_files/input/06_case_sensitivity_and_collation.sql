-- Use of COLLATE NOCASE to make text comparisons case-insensitive.
-- Identifiers with mixed casing.
-- Testing how the parser handles collation specifications.


CREATE TABLE CaseTest (
  id INTEGER PRIMARY KEY,
  value TEXT COLLATE NOCASE
);

INSERT INTO CaseTest (id, value) VALUES (1, 'Apple'), (2, 'apple');

SELECT * FROM CaseTest WHERE value = 'APPLE';
