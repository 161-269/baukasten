-- Multiple Collations: Applying multiple COLLATE clauses can confuse the lexer or parser if it doesn't expect them.
-- Conflict Resolution: The lexer must tokenize collations correctly and the parser must resolve which collation applies.


CREATE TABLE collation_test (
    value TEXT COLLATE NOCASE COLLATE BINARY COLLATE RTRIM
);

INSERT INTO collation_test (value) VALUES (' Test ');

SELECT * FROM collation_test WHERE value = 'test';
