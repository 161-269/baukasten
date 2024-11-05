Lexer error:
test/sql_files/input/49_use_of_pragmas_and_unconventional_commands.sql:13:49

-- PRAGMA in Expressions: Using PRAGMA statements within expressions or SELECT statements is not standard and can confuse the lexer.
-- Command Context: The lexer must recognize that PRAGMA is a standalone command and not a function or expression.


PRAGMA recursive_triggers = 'on';

CREATE TABLE pragma_test (
    id INTEGER PRIMARY KEY,
    value TEXT
);

-- Use a PRAGMA as part of an expression (not standard)
INSERT INTO pragma_test (value) VALUES ('Test ' 

Lexer error begins here:
v
|| PRAGMA user_version);

-- Setting a PRAGMA in an unusual place
SELECT * FROM pragma_test WHERE id = (PRAGMA page_count);
