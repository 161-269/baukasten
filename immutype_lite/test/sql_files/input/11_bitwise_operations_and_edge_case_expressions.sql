-- Use of bitwise operators (|, &, ~, <<) in expressions.
-- Bitwise operations in INSERT and WHERE clauses.
-- Testing parser's handling of bitwise syntax and precedence.


CREATE TABLE bitwise_test (
  id INTEGER PRIMARY KEY,
  flags INTEGER
);

INSERT INTO bitwise_test (id, flags) VALUES
(1, 0 | 1),
(2, 1 << 2),
(3, ~0 & 255);

SELECT id, flags FROM bitwise_test WHERE flags & 2;
