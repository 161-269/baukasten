-- Table Creation and Indexing: Creates a customers table and indexes on last_name and signup_date to optimize search queries.
-- Data Insertion: Inserts sample customer data.
-- Optimized Query: Searches for customers who signed up in a specific date range, leveraging the index on signup_date.
-- Query Plan Analysis: Uses EXPLAIN QUERY PLAN to verify that the index is being utilized by SQLite's query planner.


-- Create a table for customer data
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    signup_date DATE NOT NULL
);

-- Create indexes to optimize queries
CREATE INDEX idx_customers_last_name ON customers(last_name);
CREATE INDEX idx_customers_signup_date ON customers(signup_date);

-- Insert sample data into customers table
INSERT INTO customers (first_name, last_name, email, signup_date) VALUES
    ('John', 'Doe', 'john.doe@example.com', '2023-01-10'),
    ('Jane', 'Smith', 'jane.smith@example.com', '2023-01-15'),
    ('Emily', 'Jones', 'emily.jones@example.com', '2023-02-20'),
    ('Michael', 'Brown', 'michael.brown@example.com', '2023-03-05');

-- Query to find customers who signed up in February
SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM
    customers
WHERE
    signup_date BETWEEN '2023-02-01' AND '2023-02-28';

-- Analyze query plan to ensure indexes are used
EXPLAIN QUERY PLAN
SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM
    customers
WHERE
    signup_date BETWEEN '2023-02-01' AND '2023-02-28';
