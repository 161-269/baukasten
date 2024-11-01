-- Long Identifiers: Extremely long table and column names can cause buffer overflows or other issues in lexers that do not handle long tokens properly.
-- Token Buffer Limits: Lexers with fixed-size buffers may truncate or fail when encountering tokens exceeding expected lengths.


CREATE TABLE this_is_an_extremely_long_table_name_designed_to_test_the_lexer_and_see_how_it_handles_very_long_identifiers (
    this_is_an_extremely_long_column_name_that_might_cause_problems_if_the_lexer_has_a_fixed_buffer_size TEXT
);

INSERT INTO this_is_an_extremely_long_table_name_designed_to_test_the_lexer_and_see_how_it_handles_very_long_identifiers (
    this_is_an_extremely_long_column_name_that_might_cause_problems_if_the_lexer_has_a_fixed_buffer_size
) VALUES ('Testing long identifiers');

SELECT
    this_is_an_extremely_long_column_name_that_might_cause_problems_if_the_lexer_has_a_fixed_buffer_size
FROM
    this_is_an_extremely_long_table_name_designed_to_test_the_lexer_and_see_how_it_handles_very_long_identifiers;
