-- Creating virtual tables with fts5.
-- Using custom tokenizers.
-- Parser's handling of virtual table syntax and full-text search queries.


CREATE VIRTUAL TABLE fts_test USING fts5(content, tokenize = 'porter');

INSERT INTO fts_test (content) VALUES ('This is a test of the full-text search capabilities.');

SELECT * FROM fts_test WHERE fts_test MATCH 'test';
