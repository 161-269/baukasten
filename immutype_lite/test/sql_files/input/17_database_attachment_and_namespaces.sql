-- Using ATTACH and DETACH commands.
-- Referencing tables in attached databases with a namespace.
-- Parser handling of multiple databases in the same session.


ATTACH DATABASE 'additional.db' AS additional;

CREATE TABLE additional.new_table (
  id INTEGER PRIMARY KEY,
  data TEXT
);

INSERT INTO additional.new_table (data) VALUES ('Attached DB Entry');

SELECT * FROM additional.new_table;

DETACH DATABASE additional;
