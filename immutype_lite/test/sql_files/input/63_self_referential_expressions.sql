-- Circular References: Expressions that reference the same table and column in complex ways can challenge the lexer and parser in maintaining context.
-- Nested Queries: The lexer must correctly tokenize nested queries within expressions.


CREATE TABLE self_ref (
    id INTEGER PRIMARY KEY,
    value INTEGER
);

INSERT INTO self_ref (value) VALUES (1);

UPDATE self_ref SET value = value * (SELECT value FROM self_ref WHERE id = value);
