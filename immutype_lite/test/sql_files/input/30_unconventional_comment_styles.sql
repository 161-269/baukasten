-- Non-standard comments (e.g., /*- ... -*/).
-- Use of optimizer hints syntax (ignored in SQLite).
-- Shell-style comments (# ...) within SQL scripts.
-- Parser's ability to handle and ignore unconventional comments.


CREATE TABLE comment_test (
  id INTEGER PRIMARY KEY,
  value TEXT
);

/*- Custom comment style that might confuse the parser -*/

INSERT /*+ optimizer_hint */ INTO comment_test (value) VALUES ('Test Value'); # Shell-style comment

SELECT * FROM comment_test;
