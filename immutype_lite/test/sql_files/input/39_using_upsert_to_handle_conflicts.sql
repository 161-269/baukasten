-- Table Creation: Defines a user_profiles table with unique constraints on username and email.
-- Upsert Operation: Uses ON CONFLICT to update existing records when a conflict occurs on username.
-- Conflict Handling: Updates the email and last_login fields when an existing user is inserted again.
-- Data Verification: Queries confirm that the upsert operation behaved as expected.


-- Create a table for user profiles
CREATE TABLE user_profiles (
    user_id INTEGER PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    last_login DATE
);

-- Insert initial data into user_profiles
INSERT INTO user_profiles (username, email, last_login) VALUES
    ('alice', 'alice@example.com', '2023-03-01'),
    ('bob', 'bob@example.com', '2023-03-02');

-- Use upsert to update last_login if the user already exists
INSERT INTO user_profiles (username, email, last_login) VALUES
    ('alice', 'alice_new@example.com', DATE('now'))
ON CONFLICT(username) DO UPDATE SET
    email = excluded.email,
    last_login = excluded.last_login;

-- Verify that Alice's email and last_login have been updated
SELECT
    user_id,
    username,
    email,
    last_login
FROM
    user_profiles
WHERE
    username = 'alice';

-- Attempt to insert a new user without conflicts
INSERT INTO user_profiles (username, email, last_login) VALUES
    ('charlie', 'charlie@example.com', DATE('now'));

-- Verify that Charlie has been added
SELECT
    user_id,
    username,
    email,
    last_login
FROM
    user_profiles;
