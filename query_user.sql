WITH query AS(
            SELECT
                b.*,
                CASE WHEN b.median > 0 THEN 'positive'
                     WHEN b.median = 0 THEN 'neutral'
                     WHEN b.median < 0 THEN 'negative' 
                     END AS median_sentiment
            FROM (
                SELECT
                    "timestamp" AS agg_ts_id,
                    MAX(FROM_ISO8601_TIMESTAMP("_sdc_batched_at")) AS batch
                FROM "senticrypt"."senticrypt_table"
                GROUP BY 1) AS a
            JOIN (
                SELECT
                    FROM_ISO8601_TIMESTAMP("_sdc_batched_at") AS batch,
                    "timestamp" AS agg_ts_id,
                    "last",
                    "datetime" AS datetime_utc,
                    DATE(FROM_ISO8601_TIMESTAMP(datetime)) AS date_utc,
                    DATE_FORMAT(FROM_ISO8601_TIMESTAMP(datetime),'%H:%i:%s') AS time_utc,
                    btc_price,
                    "count",
                    mean,
                    median,
                    "sum",
                    rate
                FROM "senticrypt"."senticrypt_table") AS b
            ON a.batch = b.batch AND a.agg_ts_id = b.agg_ts_id)

SELECT
    agg_ts_id,
    datetime_utc,
    DATE(FROM_ISO8601_TIMESTAMP(datetime_utc)) AS date_utc,
    DATE_FORMAT(FROM_ISO8601_TIMESTAMP(datetime_utc),'%H:%i:%s') AS time_utc,
    btc_price,
    "count",
    "sum",
    mean,
    median,
    median_sentiment,
    rate
FROM query







