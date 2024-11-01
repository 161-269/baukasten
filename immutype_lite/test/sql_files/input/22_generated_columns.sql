-- Defining generated (computed) columns.
-- Using expressions in column definitions.
-- Parser's ability to handle GENERATED ALWAYS AS syntax.


CREATE TABLE generated_columns (
  base_value INTEGER,
  doubled_value INTEGER GENERATED ALWAYS AS (base_value * 2) STORED
);

INSERT INTO generated_columns (base_value) VALUES (10), (20);

SELECT * FROM generated_columns;
