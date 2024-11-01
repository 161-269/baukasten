-- Quotes Within Strings: The password field contains quotes that can confuse string literal parsing.
-- Comment Indicators Inside Strings: The use of -- within a string may trick the lexer into interpreting the rest of the line as a comment.
-- SQL Injection Patterns: While not executing injection, the patterns mimic injection techniques, testing the lexer's ability to distinguish between code and data.


CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    username TEXT,
    password TEXT
);

INSERT INTO users (username, password) VALUES
    ('admin', ''' OR 1=1 --'),
    ('user', 'password');

SELECT * FROM users WHERE username = 'admin' AND password = ''' OR 1=1 --';
