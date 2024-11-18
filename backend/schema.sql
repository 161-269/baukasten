CREATE TABLE storch_migrations (id integer, applied integer);

CREATE TABLE "configuration" (
	"id" INTEGER NOT NULL UNIQUE,
	"key" TEXT NOT NULL,
	"value" TEXT NOT NULL,
	"created_at" INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE TABLE sqlite_sequence(name,seq);

CREATE TABLE "user" (
	"id"	INTEGER NOT NULL UNIQUE,
	"username"	TEXT NOT NULL UNIQUE COLLATE NOCASE,
	"email"	TEXT NOT NULL UNIQUE COLLATE NOCASE,
	"password"	BLOB NOT NULL,
	CHECK("username" NOT LIKE '%@%' AND "email" LIKE '%_@_%'),
	PRIMARY KEY("id" AUTOINCREMENT)
);

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

CREATE TABLE "visitor" (
	"id" INTEGER NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE TABLE "visitor_session" (
	"session_key" BLOB NOT NULL UNIQUE,
	"visitor_id" INTEGER NOT NULL UNIQUE,
	"created_at" INTEGER NOT NULL,
	PRIMARY KEY("session_key"),
	FOREIGN KEY("visitor_id") REFERENCES "visitor"("id")
);

CREATE TABLE "request_path" (
	"id" INTEGER NOT NULL UNIQUE,
	"path" TEXT NOT NULL UNIQUE COLLATE NOCASE,
	PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE TABLE "page_request" (
	"id" INTEGER NOT NULL UNIQUE,
	"visitor_id" INTEGER NOT NULL,
	"request_path_id" INTEGER NOT NULL,
	"time" INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("visitor_id") REFERENCES "visitor"("id"),
	FOREIGN KEY("request_path_id") REFERENCES "request_path"("id")
);

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

	PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE TABLE "file" (
	"id" INTEGER NOT NULL UNIQUE,
	"hash" BLOB NOT NULL UNIQUE,
	"data" BLOB NOT NULL,
	"size" INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE TABLE "file_metadata" (
	"id" INTEGER NOT NULL UNIQUE,
	"file_id" INTEGER NOT NULL,
	"key" TEXT NOT NULL,
	"name" TEXT NOT NULL,
	"content_type" TEXT NOT NULL,
	"created_at" INTEGER NOT NULL,
	"deleted" INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("file_id") REFERENCES "file"("id")
);

CREATE INDEX "configuration_key_created_at" ON "configuration" ("key", "created_at" DESC);

CREATE INDEX "user_username" ON "user" ("username");

CREATE INDEX "user_email" ON "user" ("email");

CREATE INDEX "session_key" ON "session" ("key");

CREATE INDEX "request_path_path" ON "request_path" ("path");

CREATE INDEX "page_request_visitor_id" ON "page_request" ("visitor_id");

CREATE INDEX "page_active_path_updated_at" ON "page" ("active", "path", "updated_at" DESC);

