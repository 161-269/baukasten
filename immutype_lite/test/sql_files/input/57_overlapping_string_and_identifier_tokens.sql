-- Unescaped Single Quotes: The string O'Reilly contains an unescaped single quote, which can prematurely terminate the string literal.
-- String Boundary Detection: The lexer must handle escaped quotes or double up single quotes ('O''Reilly') to correctly parse the string.


CREATE TABLE test (
    id INTEGER PRIMARY KEY,
    value TEXT
);

INSERT INTO test (value) VALUES ('O'Reilly');

SELECT * FROM test WHERE value = 'O'Reilly';
