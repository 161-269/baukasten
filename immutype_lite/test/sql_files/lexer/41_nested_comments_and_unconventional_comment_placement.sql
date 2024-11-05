Lexer error:
test/sql_files/input/41_nested_comments_and_unconventional_comment_placement.sql:9:28

-- Nested Comments: SQLite supports C-style comments /* ... */, but does not support nested comments. Including them can confuse lexers not designed to detect improper nesting.
-- Unmatched Comment Delimiters: An unmatched /* or */ can cause the lexer to enter or exit comment mode incorrectly.
-- Comments Within Comments: Placing comment delimiters inside comments can challenge the lexer's ability to correctly identify comment blocks.
-- Comments at Unusual Positions: Comments placed in unexpected locations can disrupt tokenization if not properly handled.


/* Outer comment start
   /* Nested comment */
   Still in outer comment *

Lexer error begins here:
v
/
CREATE TABLE test_table (
    id INTEGER PRIMARY KEY, -- Inline comment /* with nested comment */
    value TEXT
);
/* Unmatched comment start
-- SELECT * FROM test_table; -- This line is commented out
