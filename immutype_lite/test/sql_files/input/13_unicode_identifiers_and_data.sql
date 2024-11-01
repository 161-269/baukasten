-- Non-ASCII Unicode characters in table and column names.
-- Unicode string literals.
-- Testing parser's support for international character sets.


CREATE TABLE 数据 (
  编号 INTEGER PRIMARY KEY,
  值 TEXT
);

INSERT INTO 数据 (编号, 值) VALUES (1, '测试');

SELECT 值 FROM 数据 WHERE 编号 = 1;
