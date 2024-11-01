-- Role-Based Access Control (RBAC) Implementation:
-- 
--     Defines roles, users, permissions, and role_permissions tables to manage access control.
-- 
-- Data Insertion: Adds sample roles, users, permissions, and assigns permissions to roles.
-- Permission Queries:
-- 
--     Retrieves permissions for a specific user.
--     Lists all users along with their roles and permissions.
-- 
-- Best Practices:
-- 
--     Uses normalized tables to avoid data redundancy.
--     Employs GROUP_CONCAT to aggregate permissions per user.


-- Create tables for users and roles
CREATE TABLE roles (
    role_id INTEGER PRIMARY KEY,
    role_name TEXT UNIQUE NOT NULL
);

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    role_id INTEGER NOT NULL,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

CREATE TABLE permissions (
    permission_id INTEGER PRIMARY KEY,
    permission_name TEXT UNIQUE NOT NULL
);

CREATE TABLE role_permissions (
    role_id INTEGER NOT NULL,
    permission_id INTEGER NOT NULL,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (permission_id) REFERENCES permissions(permission_id)
);

-- Insert sample data into roles
INSERT INTO roles (role_name) VALUES
    ('Admin'),
    ('Editor'),
    ('Viewer');

-- Insert sample data into users
INSERT INTO users (username, role_id) VALUES
    ('admin_user', 1),
    ('editor_user', 2),
    ('viewer_user', 3);

-- Insert sample data into permissions
INSERT INTO permissions (permission_name) VALUES
    ('Create'),
    ('Read'),
    ('Update'),
    ('Delete');

-- Assign permissions to roles
INSERT INTO role_permissions (role_id, permission_id) VALUES
    (1, 1), -- Admin has Create
    (1, 2), -- Admin has Read
    (1, 3), -- Admin has Update
    (1, 4), -- Admin has Delete
    (2, 2), -- Editor has Read
    (2, 3), -- Editor has Update
    (3, 2); -- Viewer has Read

-- Query to get permissions of a specific user
SELECT
    u.username,
    r.role_name,
    GROUP_CONCAT(p.permission_name, ', ') AS permissions
FROM
    users u
    INNER JOIN roles r ON u.role_id = r.role_id
    INNER JOIN role_permissions rp ON r.role_id = rp.role_id
    INNER JOIN permissions p ON rp.permission_id = p.permission_id
WHERE
    u.username = 'editor_user'
GROUP BY
    u.username,
    r.role_name;

-- View all users and their permissions
SELECT
    u.username,
    r.role_name,
    GROUP_CONCAT(p.permission_name, ', ') AS permissions
FROM
    users u
    INNER JOIN roles r ON u.role_id = r.role_id
    INNER JOIN role_permissions rp ON r.role_id = rp.role_id
    INNER JOIN permissions p ON rp.permission_id = p.permission_id
GROUP BY
    u.username,
    r.role_name
ORDER BY
    u.username;
