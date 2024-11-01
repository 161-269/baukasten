-- Tables Creation and Data Insertion: Defines products, categories, orders, and order_items tables with appropriate relationships and inserts sample data.
-- Order Summary Query:
-- 
--     Joins multiple tables to calculate the total amount per order.
--     Uses SUM to compute total amounts and GROUP_CONCAT to list ordered items.
-- 
-- Top-Selling Category Subquery:
-- 
--     Calculates total quantities sold per category.
--     Uses a subquery in the HAVING clause to find the category with the maximum total quantity sold.


-- Create a table for products
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    category_id INTEGER NOT NULL,
    price REAL NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Create a table for categories
CREATE TABLE categories (
    category_id INTEGER PRIMARY KEY,
    category_name TEXT NOT NULL
);

-- Create a table for orders
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    order_date DATE NOT NULL
);

-- Create a table for order items
CREATE TABLE order_items (
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data into categories
INSERT INTO categories (category_id, category_name) VALUES
    (1, 'Electronics'),
    (2, 'Books'),
    (3, 'Clothing');

-- Insert sample data into products
INSERT INTO products (product_name, category_id, price) VALUES
    ('Smartphone', 1, 699.99),
    ('Laptop', 1, 999.99),
    ('Novel', 2, 19.99),
    ('T-Shirt', 3, 9.99);

-- Insert sample data into orders
INSERT INTO orders (order_date) VALUES
    ('2023-03-01'),
    ('2023-03-05');

-- Insert sample data into order_items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
    (1, 1, 2), -- 2 Smartphones
    (1, 3, 1), -- 1 Novel
    (2, 2, 1), -- 1 Laptop
    (2, 4, 3); -- 3 T-Shirts

-- Complex query to get order summaries with total amounts
SELECT
    o.order_id,
    o.order_date,
    SUM(p.price * oi.quantity) AS total_amount,
    GROUP_CONCAT(p.product_name || ' x' || oi.quantity, ', ') AS items_ordered
FROM
    orders o
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY
    o.order_id,
    o.order_date
ORDER BY
    o.order_date;

-- Subquery to find the top-selling category
SELECT
    c.category_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM
    categories c
    INNER JOIN products p ON c.category_id = p.category_id
    INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY
    c.category_name
HAVING
    SUM(oi.quantity) = (
        SELECT MAX(total_quantity)
        FROM (
            SELECT SUM(oi_inner.quantity) AS total_quantity
            FROM categories c_inner
            INNER JOIN products p_inner ON c_inner.category_id = p_inner.category_id
            INNER JOIN order_items oi_inner ON p_inner.product_id = oi_inner.product_id
            GROUP BY c_inner.category_name
        )
    );
