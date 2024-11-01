-- Unsupported Preprocessor Directives: SQLite does not support macros like #define. Including them can confuse the lexer if it attempts to process these directives.
-- Lexer Expectations: The lexer must recognize that these directives are not part of SQLite syntax and handle or report them appropriately.


-- Attempting to use macros or variable substitution
#define MAX_VALUE 100

CREATE TABLE macro_test (
    id INTEGER PRIMARY KEY,
    value INTEGER CHECK (value <= MAX_VALUE)
);

INSERT INTO macro_test (value) VALUES (50);
