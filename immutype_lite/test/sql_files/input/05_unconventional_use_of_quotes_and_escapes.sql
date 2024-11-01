-- Table and column names containing quotes and special characters.
-- Escaped quotes within identifiers and string literals.
-- Mixing single and double quotes.


CREATE TABLE "weird'table" (
  "odd\"column" TEXT
);

INSERT INTO "weird'table" ("odd\"column") VALUES ('Value with ''single'' and "double" quotes');

SELECT "odd\"column" FROM "weird'table";
