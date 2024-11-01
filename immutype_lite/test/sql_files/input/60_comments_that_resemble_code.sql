-- Code in Comments: Comments containing code that could be misinterpreted as active code can confuse lexers that do not properly skip over comments.
-- Security Considerations: Ensuring that the lexer correctly ignores commented-out code is crucial to prevent unintended execution.


-- SELECT * FROM users WHERE username = 'admin'; DROP TABLE users; --
CREATE TABLE safe_table (
    id INTEGER PRIMARY KEY,
    data TEXT
);

INSERT INTO safe_table (data) VALUES ('All good here');

SELECT * FROM safe_table;
