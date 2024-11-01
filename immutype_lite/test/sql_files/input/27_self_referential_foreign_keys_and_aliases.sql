-- Self-referencing foreign keys.
-- Recursive data structures.
-- Using table aliases for self-joins.


CREATE TABLE hierarchy (
  id INTEGER PRIMARY KEY,
  parent_id INTEGER,
  name TEXT,
  FOREIGN KEY(parent_id) REFERENCES hierarchy(id)
);

INSERT INTO hierarchy (id, parent_id, name) VALUES (1, NULL, 'Root'), (2, 1, 'Child'), (3, 2, 'Grandchild');

SELECT h1.name AS child, h2.name AS parent
FROM hierarchy h1
LEFT JOIN hierarchy h2 ON h1.parent_id = h2.id;
