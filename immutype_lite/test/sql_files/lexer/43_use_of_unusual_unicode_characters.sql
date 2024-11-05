Lexer error:
test/sql_files/input/43_use_of_unusual_unicode_characters.sql:5:14

-- Unicode Identifiers: Using emojis or other Unicode characters in table and column names can break lexers that assume identifiers are ASCII-only.
-- Character Encoding Issues: If the lexer does not handle Unicode correctly, it may misinterpret or fail to tokenize these identifiers.


CREATE TABLE 

Lexer error begins here:
v
😀 (
    😂 INTEGER PRIMARY KEY,
    value TEXT
);

INSERT INTO 😀 (😂, value) VALUES (1, 'Emojis as identifiers');

SELECT * FROM 😀 WHERE 😂 = 1;
