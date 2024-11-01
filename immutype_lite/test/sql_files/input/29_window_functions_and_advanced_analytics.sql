-- Using window functions (SUM() OVER). -- 
-- Using window functions (SUM() OVER). -- PARTITION BY and ORDER BY within window functions.
-- Using window functions (SUM() OVER). -- Parser's support for advanced analytical functions.


CREATE TABLE sales (
  salesperson TEXT,
  amount INTEGER
);

INSERT INTO sales VALUES ('Alice', 500), ('Bob', 700), ('Alice', 300), ('Bob', 400);

SELECT
  salesperson,
  amount,
  SUM(amount) OVER (PARTITION BY salesperson ORDER BY amount) AS cumulative_total
FROM sales;
