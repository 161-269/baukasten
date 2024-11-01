-- Virtual Table Creation: Uses fts5 to create a full-text search virtual table articles.
-- Data Insertion: Adds sample articles with titles and bodies.
-- Full-Text Search Queries:
-- 
--     Searches for articles matching specific terms using the MATCH operator.
--     Uses snippet to extract and highlight matching text.
--     Calculates relevance scores using the bm25 ranking function.


-- Enable the FTS5 extension (if not already enabled)
-- This may require compiling SQLite with FTS5 support.

-- Create a virtual table for articles using FTS5
CREATE VIRTUAL TABLE articles USING fts5(
    title,
    body,
    content='',
    tokenize='porter'
);

-- Insert sample articles into the virtual table
INSERT INTO articles (title, body) VALUES
    ('Introduction to SQLite', 'SQLite is a lightweight, file-based database system.'),
    ('Advanced SQLite Features', 'Explore advanced features like window functions and common table expressions.'),
    ('SQLite and Full-Text Search', 'Implement full-text search using FTS5 extension in SQLite.');

-- Perform a full-text search for articles containing 'sqlite' and 'features'
SELECT
    title,
    snippet(articles, 1, '<b>', '</b>', '...', 10) AS snippet
FROM
    articles
WHERE
    articles MATCH 'sqlite AND features';

-- Display the relevance score using BM25 ranking
SELECT
    title,
    bm25(articles) AS score
FROM
    articles
WHERE
    articles MATCH 'sqlite'
ORDER BY
    score;
