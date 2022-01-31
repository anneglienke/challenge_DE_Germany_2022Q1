-- Query to check for duplicated 'timestamp' values

WITH query AS(
            SELECT
                b.*
            FROM (
                SELECT
                    "timestamp" AS agg_ts_id,
                    MAX(from_iso8601_timestamp("_sdc_batched_at")) AS batch
                FROM "senticrypt"."senticrypt_table"
                GROUP BY 1) AS a
            JOIN ( 
                SELECT
                    from_iso8601_timestamp("_sdc_batched_at") AS batch,
                    "timestamp" as agg_ts_id,
                    last,
                    datetime,
                    date(from_iso8601_timestamp(datetime)) AS "date",
                    date_format(from_iso8601_timestamp(datetime),'%H:%i:%s') AS "hour",
                    btc_price,
                    "count",
                    mean,
                    median,
                    "sum",
                    rate
                FROM "senticrypt"."senticrypt_table") AS b
                ON a.batch = b.batch and a.agg_ts_id = b.agg_ts_id
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
                    MAX(from_iso8601_timestamp("_sdc_batched_at")) AS batch
                FROM "senticrypt"."senticrypt_table"
                GROUP BY 1) AS a
            JOIN ( 
                SELECT
                    from_iso8601_timestamp("_sdc_batched_at") AS batch,
                    "timestamp" as agg_ts_id,
                    last,
                    datetime,
                    date(from_iso8601_timestamp(datetime)) AS "date",
                    date_format(from_iso8601_timestamp(datetime),'%H:%i:%s') AS "hour",
                    btc_price,
                    "count",
                    mean,
                    median,
                    "sum",
                    rate
                FROM "senticrypt"."senticrypt_table") AS b
                ON a.batch = b.batch and a.agg_ts_id = b.agg_ts_id
                )

SELECT 
*
FROM query
WHERE agg_ts_id is not Null
