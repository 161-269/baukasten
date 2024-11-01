-- Using reserved keywords (select, from, where) as table and column names without quotes.
-- No syntax errors due to SQLite's permissiveness with identifiers.
-- Potential confusion in parsing due to overlap with SQL keywords.


CREATE TABLE select (
  from INTEGER,
  where TEXT
);

INSERT INTO select(from, where) VALUES(1, 'Test');

SELECT select.from, select.where FROM select;
