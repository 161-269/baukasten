-- This is an example of a very simple time tracking application.

-- TABLES
CREATE TABLE IF NOT EXISTS
    "migration_script" (
        "version" INTEGER PRIMARY KEY,
        "identifier" TEXT NOT NULL   ,
        "up" TEXT NOT NULL           ,
        "down" TEXT NOT NULL
    );


CREATE TABLE IF NOT EXISTS
    "activity_log" (
        "timestamp" INTEGER NOT NULL,
        "active" INTEGER NOT NULL   ,
        PRIMARY KEY ("timestamp")
    );


-- INDEXES
CREATE INDEX IF NOT EXISTS "activity_log_time" ON "activity_log" ("timestamp" DESC);


-- VIEWS
CREATE VIEW
  "activity_log_report" AS
WITH
  "activity_log_with_lead" (
    "timestamp_seconds",
    "active"           ,
    "automatic"        ,
    "lead_active"      ,
    "lead_automatic"
  ) AS (
    SELECT
      "timestamp" / 1000000000.0 AS "timestamp_seconds",
      "active"                                         ,
      "automatic"                                      ,
      LEAD("active") OVER        (
        ORDER BY
          "timestamp" ASC,
          "active" DESC
      ) AS "lead_active"     ,
      LEAD("automatic") OVER (
        ORDER BY
          "timestamp" ASC,
          "active" DESC
      ) AS "lead_automatic"
    FROM
      "activity_log"
    ORDER BY
      "timestamp_seconds" ASC,
      "active" DESC
  )                                                                        ,
  "extended_activity_log" ("timestamp_seconds", "active", "is_unknown") AS (
    SELECT
      "timestamp_seconds"               ,
      "active"                          ,
      0                   AS "is_unknown"
    FROM
      "activity_log_with_lead"
    UNION ALL
    SELECT
      "timestamp_seconds"               ,
      0                   AS "active"   ,
      1                   AS "is_unknown"
    FROM
      "activity_log_with_lead"
    WHERE
      (
        "lead_automatic" == 1
        AND "lead_active" == 1
        AND "active" = 1
      )
      OR (
        "lead_active" IS NULL
        AND "active" = 1
        AND STRFTIME('%Y-%m-%d', DATETIME(DATETIME(), 'localtime')) != STRFTIME(
          '%Y-%m-%d'                                                      ,
          DATETIME(DATETIME("timestamp_seconds", 'unixepoch'), 'localtime')
        )
      )
    UNION ALL
    SELECT
      CAST(STRFTIME('%s', 'now') AS REAL) AS "timestamp_seconds",
      0                                   AS "active"           ,
      0                                   AS "is_unknown"
    FROM
      "activity_log_with_lead"
    WHERE
      "lead_active" IS NULL
      AND "active" = 1
      AND STRFTIME('%Y-%m-%d', DATETIME(DATETIME(), 'localtime')) = STRFTIME(
        '%Y-%m-%d'                                                      ,
        DATETIME(DATETIME("timestamp_seconds", 'unixepoch'), 'localtime')
      )
    ORDER BY
      "timestamp_seconds" ASC,
      "active" DESC
  )                                                                      ,
  "tidied_activity_log" ("timestamp_seconds", "active", "is_unknown") AS (
    SELECT
      "timestamp_seconds",
      "active"           ,
      "is_unknown"
    FROM
      (
        SELECT
          "timestamp_seconds" ,
          "active"            ,
          "is_unknown"        ,
          LAG("active") OVER  (
            ORDER BY
              "timestamp_seconds" ASC,
              "active" DESC
          ) AS "lag_active"
        FROM
          "extended_activity_log"
      )
    WHERE
      "lag_active" IS NULL
      OR "lag_active" != "active"
    ORDER BY
      "timestamp_seconds" ASC,
      "active" DESC
  )                    ,
  "activity_log_pairs" (
    "start_timestamp_seconds",
    "start_date_time"        ,
    "end_timestamp_seconds"  ,
    "end_date_time"          ,
    "end_is_unknown"         ,
    "duration_seconds"
  ) AS (
    SELECT
      "start_timestamp_seconds"                                                                   ,
      DATETIME(DATETIME("start_timestamp_seconds", 'unixepoch'), 'localtime') AS "start_date_time",
      "end_timestamp_seconds"                                                                     ,
      DATETIME(DATETIME("end_timestamp_seconds", 'unixepoch'), 'localtime')   AS "end_date_time"  ,
      "end_is_unknown"                                                                            ,
      "end_timestamp_seconds" - "start_timestamp_seconds"                     AS "duration_seconds"
    FROM
      (
        SELECT
          "active"                                                   ,
          "timestamp_seconds"            AS "start_timestamp_seconds",
          LEAD("timestamp_seconds") OVER (
            ORDER BY
              "timestamp_seconds" ASC,
              "active" DESC
          ) AS "end_timestamp_seconds",
          LEAD("is_unknown") OVER (
            ORDER BY
              "timestamp_seconds" ASC,
              "active" DESC
          ) AS "end_is_unknown"
        FROM
          "tidied_activity_log"
      )
    WHERE
      "active" = 1
  )                        ,
  "activity_history_pairs" (
    "start_date_time"        ,
    "start_timestamp_seconds",
    "start_date"             ,
    "end_date_time"          ,
    "end_timestamp_seconds"  ,
    "duration_seconds"       ,
    "end_is_unknown"
  ) AS (
    SELECT
      "start_date_time"                                      ,
      "start_timestamp_seconds"                              ,
      STRFTIME('%Y-%m-%d', "start_date_time") AS "start_date",
      "end_date_time"                                        ,
      "end_timestamp_seconds"                                ,
      "duration_seconds"                                     ,
      "end_is_unknown"
    FROM
      "activity_log_pairs"
    WHERE
      "duration_seconds" > 0
      OR "end_is_unknown" = 1
  )
SELECT
  "start_date_time"                                                                                             ,
  "start_timestamp_seconds"                                                                                     ,
  "end_date_time"                                                                                               ,
  "end_timestamp_seconds"                                                                                       ,
  "active_duration_seconds"                                                                                     ,
  "end_timestamp_seconds" - "start_timestamp_seconds"                             AS "total_duration_seconds"   ,
  "end_timestamp_seconds" - "start_timestamp_seconds" - "active_duration_seconds" AS "inactive_duration_seconds",
  "interval_json_array"
FROM
  (
    SELECT
      "start_date"                                                                    ,
      MIN("start_date_time")                              AS "start_date_time"        ,
      MIN("start_timestamp_seconds")                      AS "start_timestamp_seconds",
      MAX("end_date_time")                                AS "end_date_time"          ,
      MAX("end_timestamp_seconds")                        AS "end_timestamp_seconds"  ,
      SUM("duration_seconds")                             AS "active_duration_seconds",
      '[' || GROUP_CONCAT("active_pair_json", ',') || ']' AS "interval_json_array"
    FROM
      (
        SELECT
          "start_date_time"                                                                                                                                               ,
          "start_timestamp_seconds"                                                                                                                                       ,
          "end_date_time"                                                                                                                                                 ,
          "end_timestamp_seconds"                                                                                                                                         ,
          "start_date"                                                                                                                                                    ,
          "duration_seconds"                                                                                                                                              ,
          '{"start":' || CAST(("start_timestamp_seconds" * 1000.0) AS INTEGER) || ',"end":' || CAST(("end_timestamp_seconds" * 1000.0) AS INTEGER) || ',"incomplete":' || (
            CASE
              WHEN "end_is_unknown" = 1 THEN 'true'
              ELSE 'false'
            END
          ) || '}' AS "active_pair_json"
        FROM
          "activity_history_pairs"
      )
    GROUP BY
      "start_date"
  );