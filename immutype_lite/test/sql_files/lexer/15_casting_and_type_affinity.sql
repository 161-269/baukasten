Lexer error:
test/sql_files/input/15_casting_and_type_affinity.sql:6:31

-- Casting strings to different numeric types.
-- Mixing integer and real numbers in calculations.
-- Testing type affinity and conversion behaviors.


SELECT CAST('123' AS INTEGER) 

Lexer error begins here:
v
+ CAST('456.789' AS REAL) AS result;
