-- Type Ambiguity: The column a contains both integer and string representations of the number one.
-- Token Type Differentiation: Lexers may struggle if they attempt to infer types during tokenization rather than deferring to parsing or execution stages.


CREATE TABLE ambiguity_test AS SELECT 1 AS a UNION SELECT '1';

SELECT * FROM ambiguity_test WHERE a = 1;
SELECT * FROM ambiguity_test WHERE a = '1';
