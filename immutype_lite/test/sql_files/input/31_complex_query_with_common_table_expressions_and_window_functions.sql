-- Table Creation and Data Insertion: A table employee_sales is created to store sales data per employee, including their name, region, sales amount, and date.
-- Common Table Expression (CTE): The CTE cumulative_sales calculates the cumulative sales for each employee using window functions.
-- 
--     SUM(sales_amount) OVER (...) computes the running total of sales per employee over time.
--     RANK() OVER (...) assigns a rank to each sale amount per employee.
-- 
-- Final Selection: The main query selects data from the CTE, providing a detailed view of each sale, cumulative sales to date, and the rank of each sale amount per employee.


-- Create a table to store employee sales data
CREATE TABLE employee_sales (
    id INTEGER PRIMARY KEY,
    employee_name TEXT NOT NULL,
    region TEXT NOT NULL,
    sales_amount REAL NOT NULL,
    sales_date DATE NOT NULL
);

-- Insert sample data into the employee_sales table
INSERT INTO employee_sales (employee_name, region, sales_amount, sales_date) VALUES
    ('Alice', 'North', 5000.00, '2023-01-15'),
    ('Bob', 'South', 7000.00, '2023-01-20'),
    ('Alice', 'North', 8000.00, '2023-02-10'),
    ('Charlie', 'East', 6000.00, '2023-02-15'),
    ('Bob', 'South', 4000.00, '2023-03-05'),
    ('Charlie', 'East', 7000.00, '2023-03-10');

-- Use a Common Table Expression (CTE) and window functions to calculate cumulative sales per employee
WITH cumulative_sales AS (
    SELECT
        employee_name,
        region,
        sales_amount,
        sales_date,
        SUM(sales_amount) OVER (
            PARTITION BY employee_name
            ORDER BY sales_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS total_sales_to_date,
        RANK() OVER (
            PARTITION BY employee_name
            ORDER BY sales_amount DESC
        ) AS sales_rank
    FROM
        employee_sales
)

-- Select employee cumulative sales and their sales rank
SELECT
    employee_name,
    region,
    sales_amount,
    sales_date,
    total_sales_to_date,
    sales_rank
FROM
    cumulative_sales
ORDER BY
    employee_name,
    sales_date;
