Lexer error:
test/sql_files/input/07_recursive_common_table_expressions.sql:10:33

-- Use of WITH RECURSIVE for CTEs.
-- Recursive queries.
-- Testing the parser's ability to handle advanced query structures.


WITH RECURSIVE
  cnt(x) AS (
    SELECT 1
    UNION ALL
    SELECT x+1 FROM cnt WHERE x 

Lexer error begins here:
v
< 5
  )
SELECT x FROM cnt;
