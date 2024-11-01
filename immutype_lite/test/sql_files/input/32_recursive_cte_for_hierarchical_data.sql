-- Table Creation and Data Insertion: An employees table is created to represent an organization's hierarchy, with a self-referencing foreign key manager_id.
-- Recursive CTE: The org_chart CTE recursively traverses the employee hierarchy.
-- 
--     Anchor Member: Selects the top-level employee (e.g., CEO) where manager_id is NULL.
--     Recursive Member: Joins the employees table with the org_chart CTE to find direct reports.
-- 
-- Final Selection: Outputs the hierarchical structure with indentation to represent different levels.


-- Create a table to store employee hierarchy
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    employee_name TEXT NOT NULL,
    manager_id INTEGER, -- Self-referencing foreign key
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- Insert sample data into the employees table
INSERT INTO employees (employee_id, employee_name, manager_id) VALUES
    (1, 'CEO', NULL),
    (2, 'VP of Sales', 1),
    (3, 'Sales Manager', 2),
    (4, 'Sales Associate', 3),
    (5, 'VP of Engineering', 1),
    (6, 'Engineering Manager', 5),
    (7, 'Engineer', 6);

-- Use a Recursive CTE to traverse the employee hierarchy
WITH RECURSIVE org_chart AS (
    -- Anchor member: select the top-level manager (CEO)
    SELECT
        employee_id,
        employee_name,
        manager_id,
        1 AS level
    FROM
        employees
    WHERE
        manager_id IS NULL

    UNION ALL

    -- Recursive member: select employees reporting to the current level
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        oc.level + 1 AS level
    FROM
        employees e
        INNER JOIN org_chart oc ON e.manager_id = oc.employee_id
)

-- Select the hierarchical organization chart
SELECT
    employee_id,
    employee_name,
    manager_id,
    level,
    -- Indent employee names based on their level in the hierarchy
    REPLACE(PRINTF('%' || (level * 4) || 's', ''), ' ', '    ') || employee_name AS indented_name
FROM
    org_chart
ORDER BY
    level,
    manager_id;
