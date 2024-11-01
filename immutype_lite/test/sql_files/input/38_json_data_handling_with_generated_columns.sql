-- Table Creation with Generated Columns: Creates a json_data table that stores JSON strings and uses generated columns to extract fields.
-- Data Insertion: Inserts JSON data as text.
-- Querying Generated Columns: Allows querying directly on extracted fields without parsing JSON manually.
-- Updating JSON Data: Updates the JSON field using json_set, and the generated columns automatically reflect the changes.


-- Enable the JSON1 extension (if not already enabled)
-- This may require compiling SQLite with JSON1 support.

-- Create a table to store JSON data
CREATE TABLE json_data (
    id INTEGER PRIMARY KEY,
    data TEXT NOT NULL,
    name TEXT GENERATED ALWAYS AS (json_extract(data, '$.name')) STORED,
    age INTEGER GENERATED ALWAYS AS (json_extract(data, '$.age')) STORED,
    city TEXT GENERATED ALWAYS AS (json_extract(data, '$.address.city')) STORED
);

-- Insert sample JSON data
INSERT INTO json_data (data) VALUES
    ('{"name": "Alice", "age": 30, "address": {"city": "New York", "zip": "10001"}}'),
    ('{"name": "Bob", "age": 25, "address": {"city": "Los Angeles", "zip": "90001"}}');

-- Query the table using generated columns
SELECT
    id,
    name,
    age,
    city
FROM
    json_data
WHERE
    city = 'New York';

-- Update JSON data and observe changes in generated columns
UPDATE json_data
SET data = json_set(data, '$.age', 31)
WHERE name = 'Alice';

-- Verify the update
SELECT
    id,
    name,
    age,
    city
FROM
    json_data
WHERE
    name = 'Alice';
