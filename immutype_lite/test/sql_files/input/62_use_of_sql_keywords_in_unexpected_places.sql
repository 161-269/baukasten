-- Keywords as Identifiers Without Quotes: Using SQL keywords as column names without quoting can mislead the lexer into interpreting them as part of the SQL syntax.
-- Context-Sensitive Tokenization: The lexer must be able to determine when a keyword is being used as an identifier versus its role in SQL syntax.


CREATE TABLE keyword_confusion (
    select INTEGER,
    from TEXT,
    where INTEGER
);

INSERT INTO keyword_confusion (select, from, where) VALUES (1, 'Data', 2);

SELECT select, from, where FROM keyword_confusion WHERE where = 2;
