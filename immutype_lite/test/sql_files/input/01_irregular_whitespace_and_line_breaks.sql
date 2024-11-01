-- Excessive and irregular spaces.
-- Line breaks inserted at unconventional points.
-- Table name enclosed in quotes.
-- Missing spaces after commas in the INSERT statement.
-- Inconsistent casing in SQL keywords.


  CREATE    TABLE   "MyTable"
(
   id   INTEGER   PRIMARY KEY,    name TEXT
);

INSERT INTO   "MyTable"(id,name)VALUES(1,'Alice'),(2,'Bob');

 SELECT  *  FROM
"MyTable";

