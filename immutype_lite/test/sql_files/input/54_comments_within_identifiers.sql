-- Comments Inside Identifiers: Placing comments inside quoted identifiers is syntactically invalid but can cause the lexer to misinterpret where identifiers start and end.
-- Lexer Robustness: The lexer must properly handle or report errors when encountering such invalid constructs.


CREATE TABLE /* comment */ "my/*weird*/table" (
    id INTEGER PRIMARY KEY,
    value TEXT
);

INSERT INTO "my/*weird*/table" (value) VALUES ('Test');

SELECT * FROM "my/*weird*/table";
