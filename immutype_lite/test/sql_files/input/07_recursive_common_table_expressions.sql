-- Use of WITH RECURSIVE for CTEs.
-- Recursive queries.
-- Testing the parser's ability to handle advanced query structures.


WITH RECURSIVE
  cnt(x) AS (
    SELECT 1
    UNION ALL
    SELECT x+1 FROM cnt WHERE x < 5
  )
SELECT x FROM cnt;
