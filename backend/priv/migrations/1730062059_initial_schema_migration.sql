-- Initial schema migration
-- gleam run -m feather -- new "Initial schema migration"
-- gleam run -m feather -- schema

---------
-- TABLES
---------

-- This table contains configuration information.
-- It is used to store general settings from this instance.
CREATE TABLE "configuration" (
	"key" TEXT NOT NULL,
	"value" TEXT NOT NULL,
	"created_at" INTEGER NOT NULL,
	PRIMARY KEY("key", "created_at" DESC)
);

-- This table contains user information including their credentials.
-- Those users are maintainer or editor of the website.
CREATE TABLE "user" (
	"id"	INTEGER NOT NULL UNIQUE,
	"username"	TEXT NOT NULL UNIQUE COLLATE NOCASE,
	"email"	TEXT NOT NULL UNIQUE COLLATE NOCASE,
	"password"	BLOB NOT NULL,
	CHECK("username" LIKE '__%' AND "username" NOT LIKE '%@%' AND "email" LIKE '%_@_%'),
	PRIMARY KEY("id" AUTOINCREMENT)
);

-- A session is used for the storage of a user's authentication information.
-- It is used to identify the user and to grant access to specific parts of the website.
-- Sessions can be deleted on logout or after they expire.
CREATE TABLE "session" (
	"id"	INTEGER NOT NULL UNIQUE,
	"key" BLOB NOT NULL UNIQUE,
	"user_id"	INTEGER NOT NULL,
	"created_at"	INTEGER NOT NULL,
	"expires_at"	INTEGER NOT NULL,
	"user_agent"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "user"("id")
);

-- A visitor is used to trace navigation's from everyone on the website.
-- It is used to group requests.
CREATE TABLE "visitor" (
	"id" INTEGER NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);

-- A visitor session is used to link a session to a visitor.
-- Sessions are generated on first request and are stored as a cookie.
-- Since crawlers or automated scripts could flood this table, entries are deleted after some time.
CREATE TABLE "visitor_session" (
	"session_key" BLOB NOT NULL UNIQUE,
	"visitor_id" INTEGER NOT NULL UNIQUE,
	"created_at" INTEGER NOT NULL,
	PRIMARY KEY("session_key"),
	FOREIGN KEY("visitor_id") REFERENCES "visitor"("id")
);

-- This represents a path that a user visited.
-- It is used to avoid string duplication.
CREATE TABLE "request_path" (
	"id" INTEGER NOT NULL UNIQUE,
	"path" TEXT NOT NULL UNIQUE COLLATE NOCASE,
	PRIMARY KEY("id" AUTOINCREMENT)
);

-- A page request is used to track page views.
-- Every request is logged here and can be used to generate statistics.
-- Since those requests are linked to a visitor, they can show navigation patterns.
CREATE TABLE "page_request" (
	"id" INTEGER NOT NULL UNIQUE,
	"visitor_id" INTEGER NOT NULL,
	"request_path_id" INTEGER NOT NULL,
	"time" INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("visitor_id") REFERENCES "visitor"("id"),
	FOREIGN KEY("request_path_id") REFERENCES "request_path"("id")
);

-- This represents a page with its content.
CREATE TABLE "page" (
	"id" INTEGER NOT NULL UNIQUE,
	"path" TEXT NOT NULL COLLATE NOCASE,

	"title" TEXT NOT NULL,
	"description" TEXT,
	
	"widgets_json" BLOB NOT NULL,
	"generated_html" BLOB,
	"generated_css" BLOB,
	
	"created_at" INTEGER NOT NULL,
	"updated_at" INTEGER NOT NULL,

	"active" INTEGER NOT NULL,
	"deleted" INTEGER NOT NULL,

	PRIMARY KEY("id" AUTOINCREMENT)
);

-- This represents a file with its content.
-- Files have a hash to avoid duplication.
CREATE TABLE "file" (
	"id" INTEGER NOT NULL UNIQUE,
	"hash" BLOB NOT NULL UNIQUE,
	"data" BLOB NOT NULL,
	"size" INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);

-- This represents a file's metadata.
-- The key is used for security reasons to avoid searching for ids.
CREATE TABLE "file_metadata" (
	"id" INTEGER NOT NULL UNIQUE,
	"file_id" INTEGER NOT NULL,
	"key" BLOB NOT NULL UNIQUE,
	"name" TEXT NOT NULL,
	"content_type" TEXT,
	"created_at" INTEGER NOT NULL,
	"updated_at" INTEGER NOT NULL,
	"deleted" INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("file_id") REFERENCES "file"("id")
);

-- This table is used to route static files.
-- It enables to host and distribute static files.
CREATE TABLE "static_file" (
	"id" INTEGER NOT NULL UNIQUE,
	"path" TEXT NOT NULL UNIQUE COLLATE NOCASE,
	"file_metadata_id" INTEGER NOT NULL,
	"deleted" INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("file_metadata_id") REFERENCES "file_metadata"("id")
);

-- This tables stores generated files.
-- It can be used to cache css and js files.
-- But it also is used to store gzipped files.
-- Files in this table can be deleted at any time.
CREATE TABLE "generated_file" (
	"id" INTEGER NOT NULL UNIQUE,
	"key" TEXT NOT NULL UNIQUE,
	"size" INTEGER NOT NULL,
	"created_at" INTEGER NOT NULL,
	"data" BLOB NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);

----------
-- INDEXES
----------

CREATE INDEX "configuration_key_created_at" ON "configuration" ("key", "created_at" DESC);

CREATE INDEX "user_username" ON "user" ("username");
CREATE INDEX "user_email" ON "user" ("email");

CREATE INDEX "session_key" ON "session" ("key");

CREATE INDEX "request_path_path" ON "request_path" ("path");

CREATE INDEX "page_request_visitor_id" ON "page_request" ("visitor_id");

CREATE INDEX "page_deleted_updated_at" ON "page" ("deleted", "updated_at" ASC);
CREATE INDEX "page_deleted_active_path_updated_at" ON "page" ("deleted", "active", "path", "updated_at" DESC);

CREATE INDEX "file_hash" ON "file" ("hash");

CREATE INDEX "file_metadata_key" ON "file_metadata" ("key");

CREATE INDEX "static_file_path" ON "static_file" ("path");
CREATE INDEX "static_file_deleted_path" ON "static_file" ("deleted", "path");

CREATE INDEX "generated_file_key" ON "generated_file" ("key");
