CREATE TABLE storch_migrations (id integer, applied integer);

CREATE TABLE "configuration" (
	"key" TEXT NOT NULL,
	"value" TEXT NOT NULL,
	"created_at" INTEGER NOT NULL,
	PRIMARY KEY("key", "created_at" DESC)
);

CREATE TABLE "user" (
	"id"	INTEGER NOT NULL UNIQUE,
	"username"	TEXT NOT NULL UNIQUE COLLATE NOCASE,
	"email"	TEXT NOT NULL UNIQUE COLLATE NOCASE,
	"password"	BLOB NOT NULL,
	"read_changelog_version" TEXT,
	CHECK("username" LIKE '__%' AND "username" NOT LIKE '%@%' AND "email" LIKE '%_@_%'),
	PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE TABLE sqlite_sequence(name,seq);

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
	"deleted" INTEGER NOT NULL,

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
	"key" BLOB NOT NULL UNIQUE,
	"name" TEXT NOT NULL,
	"content_type" TEXT,
	"created_at" INTEGER NOT NULL,
	"updated_at" INTEGER NOT NULL,
	"deleted" INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("file_id") REFERENCES "file"("id")
);

CREATE TABLE "static_file" (
	"id" INTEGER NOT NULL UNIQUE,
	"path" TEXT NOT NULL COLLATE NOCASE,
	"file_metadata_id" INTEGER NOT NULL,
	"deleted" INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("file_metadata_id") REFERENCES "file_metadata"("id")
);

CREATE TABLE "generated_file" (
	"id" INTEGER NOT NULL UNIQUE,
	"key" TEXT NOT NULL UNIQUE,
	"size" INTEGER NOT NULL,
	"created_at" INTEGER NOT NULL,
	"data" BLOB NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE TABLE "stat_page_request_10_minutes"(
	"time" INTEGER NOT NULL,
	"request_path_id" INTEGER NOT NULL,
	"count" INTEGER NOT NULL,
	PRIMARY KEY("time", "request_path_id"),
	FOREIGN KEY("request_path_id") REFERENCES "request_path"("id")
) WITHOUT ROWID;

CREATE TABLE "stat_page_request_day"(
	"time" INTEGER NOT NULL,
	"request_path_id" INTEGER NOT NULL,
	"count" INTEGER NOT NULL,
	PRIMARY KEY("time", "request_path_id"),
	FOREIGN KEY("request_path_id") REFERENCES "request_path"("id")
) WITHOUT ROWID;

CREATE TABLE "stat_page_request_month"(
	"time" INTEGER NOT NULL,
	"request_path_id" INTEGER NOT NULL,
	"count" INTEGER NOT NULL,
	PRIMARY KEY("time", "request_path_id"),
	FOREIGN KEY("request_path_id") REFERENCES "request_path"("id")
) WITHOUT ROWID;

CREATE INDEX "session_user_id" ON "session" ("user_id");

CREATE INDEX "visitor_session_created_at" ON "visitor_session" ("created_at");

CREATE INDEX "page_request_visitor_id_time" ON "page_request" ("visitor_id", "time");

CREATE INDEX "page_request_request_path_id_time" ON "page_request" ("request_path_id", "time");

CREATE INDEX "page_deleted_updated_at" ON "page" ("deleted", "updated_at" ASC);

CREATE INDEX "page_deleted_active_path_updated_at" ON "page" ("deleted", "active", "path", "updated_at" DESC);

CREATE INDEX "static_file_path" ON "static_file" ("path");

CREATE INDEX "static_file_deleted_path" ON "static_file" ("deleted", "path");

CREATE TRIGGER "page_request_insert"
AFTER INSERT ON "page_request"
BEGIN
	INSERT INTO "stat_page_request_10_minutes" (
		"time",
		"request_path_id",
		"count"
	) VALUES (
		(CAST(NEW."time" / 600000 AS INTEGER) * 600000),
		NEW."request_path_id",
		1
	) ON CONFLICT (
		"time",
		"request_path_id"
	) DO UPDATE SET
		"count" = "count" + 1;
END;

CREATE TRIGGER "stat_page_request_10_minutes_insert"
AFTER INSERT ON "stat_page_request_10_minutes"
BEGIN
	INSERT INTO "stat_page_request_day" (
		"time",
		"request_path_id",
		"count"
	) VALUES (
		strftime(
			'%s',
			datetime(
				NEW."time" / 1000,
				'unixepoch',
				'localtime',
				'start of day',
				'utc'
			)
		) * 1000,
		NEW."request_path_id",
		NEW."count"
	) ON CONFLICT (
		"time",
		"request_path_id"
	) DO UPDATE SET
		"count" = "count" + NEW."count";
END;

CREATE TRIGGER "stat_page_request_10_minutes_update"
AFTER UPDATE ON "stat_page_request_10_minutes"
BEGIN
	INSERT INTO "stat_page_request_day" (
		"time",
		"request_path_id",
		"count"
	) VALUES (
		strftime(
			'%s',
			datetime(
				NEW."time" / 1000,
				'unixepoch',
				'localtime',
				'start of day',
				'utc'
			)
		) * 1000,
		NEW."request_path_id",
		NEW."count"
	) ON CONFLICT (
		"time",
		"request_path_id"
	) DO UPDATE SET
		"count" = "count" + NEW."count" - OLD."count";
END;

CREATE TRIGGER "stat_page_request_day_insert"
AFTER INSERT ON "stat_page_request_day"
BEGIN
	INSERT INTO "stat_page_request_month" (
		"time",
		"request_path_id",
		"count"
	) VALUES (
		strftime(
			'%s',
			datetime(
				NEW."time" / 1000,
				'unixepoch',
				'localtime',
				'start of month',
				'utc'
			)
		) * 1000,
		NEW."request_path_id",
		NEW."count"
	) ON CONFLICT (
		"time",
		"request_path_id"
	) DO UPDATE SET
		"count" = "count" + NEW."count";
END;

CREATE TRIGGER "stat_page_request_day_update"
AFTER UPDATE ON "stat_page_request_day"
BEGIN
	INSERT INTO "stat_page_request_month" (
		"time",
		"request_path_id",
		"count"
	) VALUES (
		strftime(
			'%s',
			datetime(
				NEW."time" / 1000,
				'unixepoch',
				'localtime',
				'start of month',
				'utc'
			)
		) * 1000,
		NEW."request_path_id",
		NEW."count"
	) ON CONFLICT (
		"time",
		"request_path_id"
	) DO UPDATE SET
		"count" = "count" + NEW."count" - OLD."count";
END;

