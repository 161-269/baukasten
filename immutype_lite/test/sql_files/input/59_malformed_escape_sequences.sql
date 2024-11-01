-- Invalid Escape Sequences: \z is not a valid escape sequence in SQLite. Lexers must handle invalid escapes properly.
-- String Parsing: The lexer must not crash or behave unexpectedly when encountering malformed escapes.


CREATE TABLE escape_test (
    id INTEGER PRIMARY KEY,
    value TEXT
);

INSERT INTO escape_test (value) VALUES ('This is a test\z');

SELECT * FROM escape_test WHERE value LIKE 'This%';
