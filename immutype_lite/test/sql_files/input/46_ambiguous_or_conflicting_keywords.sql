-- Keywords as Identifiers: Using SQL keywords as table and column names can confuse the lexer if it does not differentiate between keywords and identifiers based on context.
-- Quoted Identifiers: The use of quotes around identifiers is essential here, and missing them can change the meaning entirely.


CREATE TABLE "select" (
    "from" TEXT,
    "where" TEXT
);

INSERT INTO "select" ("from", "where") VALUES ('Data', 'More Data');

SELECT "from", "where" FROM "select" WHERE "where" = 'More Data';
