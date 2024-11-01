-- Very long table and column names.
-- Extremely long string literals.
-- Testing parser limits for identifier and literal lengths.


CREATE TABLE "this_is_an_extremely_long_table_name_that_should_still_be_valid_in_sql_but_is_unnecessarily_verbose" (
  "this_is_an_extremely_long_column_name_that_tests_the_parser_limits" TEXT
);

INSERT INTO "this_is_an_extremely_long_table_name_that_should_still_be_valid_in_sql_but_is_unnecessarily_verbose" (
  "this_is_an_extremely_long_column_name_that_tests_the_parser_limits"
) VALUES ('This is a very long string literal that is used to test the parser\'s ability to handle large amounts of text in a single statement without breaking.');

SELECT * FROM "this_is_an_extremely_long_table_name_that_should_still_be_valid_in_sql_but_is_unnecessarily_verbose";
