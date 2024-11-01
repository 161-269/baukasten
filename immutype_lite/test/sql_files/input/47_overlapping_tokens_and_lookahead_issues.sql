-- No Spaces Between Tokens: The SELECTvalue FROMlookahead_testWHEREid=1; line intentionally omits spaces between tokens.
-- Token Boundary Detection: The lexer must correctly identify where one token ends and the next begins without relying on whitespace.


CREATE TABLE lookahead_test (
    id INTEGER PRIMARY KEY,
    value TEXT
);

INSERT INTO lookahead_test (id, value) VALUES (1, 'Test'), (2, 'Another Test');

SELECTvalue FROMlookahead_testWHEREid=1;
