-- Attempting to use RIGHT OUTER JOIN (SQLite does not support this).
-- Combining results with UNION.
-- Parser's error detection for unsupported syntax.


CREATE TABLE t1(a INTEGER);
CREATE TABLE t2(a INTEGER);

INSERT INTO t1 VALUES (1), (2), (3);
INSERT INTO t2 VALUES (2), (3), (4);

SELECT x.a, y.a FROM t1 AS x LEFT OUTER JOIN t2 AS y ON x.a = y.a
UNION
SELECT x.a, y.a FROM t1 AS x RIGHT OUTER JOIN t2 AS y ON x.a = y.a
ORDER BY 1, 2;
