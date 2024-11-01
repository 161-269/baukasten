-- Escaped Quotes in Identifiers: The table name includes escaped quotes, testing the lexer's ability to handle escaped characters in identifiers.
-- Multiline String Literals: SQLite supports multiline string literals, which can cause issues if the lexer expects strings to be on a single line.
-- Backslashes and Quotes in Strings: Strings containing backslashes and various quote types can confuse lexers that do not handle escape sequences correctly.
-- Hexadecimal Literals and Functions: Mixing hexadecimal string literals with functions like char() and concatenation operators can complicate tokenization.


CREATE TABLE "strange\"table" (
    id INTEGER PRIMARY KEY,
    data TEXT
);

INSERT INTO "strange\"table" (data) VALUES (
    'Line1
    Line2'
), (
    'Text with backslashes \\ and quotes \' " '''
), (
    X'48656C6C6F20576F726C64' || char(0x0A) || 'Newline character'
);

SELECT * FROM "strange\"table";
