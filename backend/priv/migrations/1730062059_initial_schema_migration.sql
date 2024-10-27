-- Initial schema migration
-- gleam run -m feather -- new "Initial schema migration"
-- gleam run -m feather -- schema

CREATE TABLE "page_state" (
	"id"	INTEGER NOT NULL UNIQUE,
	"previous_state"	INTEGER,
	"time"	INTEGER NOT NULL,
	"name"	TEXT,
	"json"	BLOB NOT NULL,
	"html"	BLOB,
	"css"	BLOB,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("previous_state") REFERENCES "page_state"("id")
);