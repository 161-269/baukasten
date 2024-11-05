Lexer error:
test/sql_files/input/18_pragmma_statements_with_odd_parameters.sql:7:21

-- Setting unusual PRAGMA parameters (negative cache size).
-- Changing database encoding to UTF-16 little endian.
-- Parser's handling of PRAGMA statements with various parameters.


PRAGMA page_size = 1024;
PRAGMA cache_size = 

Lexer error begins here:
v
-2000;
PRAGMA encoding = 'UTF-16le';

CREATE TABLE pragma_test (
  id INTEGER PRIMARY KEY,
  value TEXT
);

INSERT INTO pragma_test (value) VALUES ('Test Encoding');

SELECT * FROM pragma_test;
