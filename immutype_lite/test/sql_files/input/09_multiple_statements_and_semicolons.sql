-- Multiple statements on a single line.
-- Lack of line breaks between statements.
-- Testing parser's ability to correctly separate and parse multiple statements.


CREATE TABLE multi_stmt(id INTEGER PRIMARY KEY); INSERT INTO multi_stmt VALUES (1); INSERT INTO multi_stmt VALUES (2);

SELECT * FROM multi_stmt; SELECT COUNT(*) FROM multi_stmt;
