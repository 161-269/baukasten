-- Number Formats: SQLite does not support hexadecimal (0x) or octal (0) number literals. Including them can cause lexers to misinterpret number tokens.
-- Lexer Number Parsing: The lexer must correctly tokenize numbers and handle unsupported formats appropriately.


CREATE TABLE number_test (
    id INTEGER PRIMARY KEY,
    value INTEGER
);

INSERT INTO number_test (value) VALUES (10), (0x0A), (012);

SELECT * FROM number_test WHERE value = 10;
