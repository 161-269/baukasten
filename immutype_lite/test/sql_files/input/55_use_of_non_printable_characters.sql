-- Control Characters in Strings: Including non-printable control characters can disrupt lexers that are not designed to handle them.
-- Character Encoding and Representation: The lexer must correctly process and represent these characters internally.


CREATE TABLE non_printable (
    id INTEGER PRIMARY KEY,
    value TEXT
);

INSERT INTO non_printable (value) VALUES ('Data with control character \x01 in it');

SELECT * FROM non_printable WHERE value LIKE '%\x01%';
