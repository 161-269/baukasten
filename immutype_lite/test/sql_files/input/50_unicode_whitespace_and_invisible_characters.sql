-- Unicode Whitespace: The code uses Unicode non-breaking spaces and other whitespace characters that are visually similar to regular spaces but have different code points.
-- Token Separation Issues: Lexers that rely on specific ASCII whitespace characters may fail to properly tokenize input containing Unicode whitespace.


CREATE TABLE unicode_whitespace(
    id INTEGER PRIMARY KEY,
    value TEXT
);

INSERT INTO unicode_whitespace(id, value) VALUES(1, 'Data with unicode spaces');

SELECT * FROM unicode_whitespace WHERE id=1;
