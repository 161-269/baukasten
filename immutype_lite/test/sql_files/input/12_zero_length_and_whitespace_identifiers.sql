-- Empty string ("") and whitespace (" ") as table and column names.
-- Quotes used to create zero-length identifiers.
-- Parsing challenges with ambiguous or empty identifiers.


CREATE TABLE "" (
  "" INTEGER PRIMARY KEY,
  " " TEXT
);

INSERT INTO "" ( "", " " ) VALUES (1, 'Test');

SELECT " " FROM "";
