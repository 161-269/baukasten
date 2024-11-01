-- Reserved Words as Identifiers: Using words like constraint, check, foreign, which are reserved in certain contexts, can confuse the lexer if it doesn't handle them appropriately.
-- Contextual Keyword Recognition: The lexer must differentiate between reserved words used as identifiers and those used in their reserved context.


CREATE TABLE reserved_words (
    id INTEGER PRIMARY KEY,
    constraint TEXT,
    check INTEGER
);

INSERT INTO reserved_words (constraint, check) VALUES ('Test', 1);

ALTER TABLE reserved_words ADD COLUMN foreign INTEGER;

SELECT constraint, check, foreign FROM reserved_words;
