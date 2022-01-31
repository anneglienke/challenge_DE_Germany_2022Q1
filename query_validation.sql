-- Query to check for duplicated 'timestamp' values

WITH query AS(
            SELECT
                b.*
            FROM (
                SELECT
                    "timestamp" AS agg_ts_id,
                    MAX(FROM_ISO8601_TIMESTAMP("_sdc_batched_at")) AS batch
                FROM "senticrypt"."senticrypt_table"
                GROUP BY 1) AS a
            JOIN ( 
                SELECT
                    FROM_ISO8601_TIMESTAMP("_sdc_batched_at") AS batch,
                    "timestamp" as agg_ts_id,
                    "last",
                    "datetime",
                    date(FROM_ISO8601_TIMESTAMP(datetime)) AS "date_utc",
                    date_format(FROM_ISO8601_TIMESTAMP(datetime),'%H:%i:%s') AS "time_utc",
                    btc_price,
                    "count",
                    mean,
                    median,
                    "sum",
                    rate
                FROM "senticrypt"."senticrypt_table") AS b
                ON a.batch = b.batch AND a.agg_ts_id = b.agg_ts_id
                )
SELECT 
    agg_ts_id,
    COUNT(agg_ts_id)
FROM query
GROUP BY 1 
HAVING COUNT(agg_ts_id) > 1


-- Query to check for null or empty 'timestamp' values

WITH query AS(
            SELECT
                b.*
            FROM (
                SELECT
                    "timestamp" AS agg_ts_id,
                    MAX(FROM_ISO8601_TIMESTAMP("_sdc_batched_at")) AS batch
                FROM "senticrypt"."senticrypt_table"
                GROUP BY 1) AS a
            JOIN ( 
                SELECT
                    FROM_ISO8601_TIMESTAMP("_sdc_batched_at") AS batch,
                    "timestamp" as agg_ts_id,
                    "last",
                    "datetime",
                    date(FROM_ISO8601_TIMESTAMP(datetime)) AS "date_utc",
                    date_format(FROM_ISO8601_TIMESTAMP(datetime),'%H:%i:%s') AS "time_utc",
                    btc_price,
                    "count",
                    mean,
                    median,
                    "sum",
                    rate
                FROM "senticrypt"."senticrypt_table") AS b
                ON a.batch = b.batch AND a.agg_ts_id = b.agg_ts_id
                )

SELECT 
*
FROM query
WHERE agg_ts_id is Null
