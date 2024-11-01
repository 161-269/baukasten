-- Invalid Delimiters: Using square brackets [ ] as identifier delimiters is common in some SQL dialects but not valid in SQLite.
-- Alternate Delimiters: Backticks ` are allowed in SQLite for compatibility but may not be expected.
-- Lexer Flexibility: The lexer must handle or properly reject invalid syntax while accepting valid alternate delimiters.


CREATE TABLE mix_delim [id INTEGER]; -- Using square brackets (invalid in SQLite)

-- However, SQLite supports using backticks for identifiers
CREATE TABLE `backtick_table` (
    `key` INTEGER PRIMARY KEY,
    `value` TEXT
);

INSERT INTO `backtick_table` (`key`, `value`) VALUES (1, 'Data');

SELECT `value` FROM `backtick_table` WHERE `key` = 1;
