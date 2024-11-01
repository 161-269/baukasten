-- Chained Operators: Using operators like >>> and <<< (which are not standard in SQLite) without spaces can confuse the lexer.
-- Operator Recognition: The lexer must correctly tokenize operators and not misinterpret >> followed by > as a single >>> operator.


CREATE TABLE operator_test (
    id INTEGER PRIMARY KEY,
    value INTEGER
);

INSERT INTO operator_test (value) VALUES (1), (2), (3);

SELECT * FROM operator_test WHERE value>>>1;
SELECT * FROM operator_test WHERE value<<<=2;
