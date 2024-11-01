-- Setting unusual PRAGMA parameters (negative cache size).
-- Changing database encoding to UTF-16 little endian.
-- Parser's handling of PRAGMA statements with various parameters.


PRAGMA page_size = 1024;
PRAGMA cache_size = -2000;
PRAGMA encoding = 'UTF-16le';

CREATE TABLE pragma_test (
  id INTEGER PRIMARY KEY,
  value TEXT
);

INSERT INTO pragma_test (value) VALUES ('Test Encoding');

SELECT * FROM pragma_test;
