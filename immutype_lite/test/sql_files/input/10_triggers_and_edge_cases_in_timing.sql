-- Use of triggers with AFTER INSERT.
-- Accessing NEW values within triggers.
-- String concatenation in SQL statements.
-- Testing the parser's handling of trigger bodies.


CREATE TABLE log (
  entry TEXT
);

CREATE TABLE data (
  id INTEGER PRIMARY KEY,
  value TEXT
);

CREATE TRIGGER data_after_insert AFTER INSERT ON data
BEGIN
  INSERT INTO log (entry) VALUES ('Inserted value: ' || NEW.value);
END;

INSERT INTO data (value) VALUES ('Test');

SELECT * FROM log;
