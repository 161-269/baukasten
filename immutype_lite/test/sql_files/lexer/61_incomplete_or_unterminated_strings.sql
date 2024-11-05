Lexer error:
test/sql_files/input/61_incomplete_or_unterminated_strings.sql:10:49

-- Unterminated String Literals: Missing the closing quote can cause the lexer to consume the rest of the file as part of the string.
-- Error Handling: The lexer must detect and report unterminated strings to prevent cascading errors.


CREATE TABLE unterminated_string (
    id INTEGER PRIMARY KEY,
    value TEXT
);

INSERT INTO unterminated_string (value) VALUES (

Lexer error begins here:
v
'This string never ends...

SELECT * FROM unterminated_string;
