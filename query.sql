SELECT
datetime,
date(from_iso8601_timestamp(datetime)) as "date",
date_format(from_iso8601_timestamp(datetime),'%H:%i:%s') as "hour",
btc_price,
"count",
mean,
median,
"sum",
rate
FROM "senticrypt"."senticrypt_table"


DEDUP

WITH a AS(
SELECT
"timestamp",
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
FROM "senticrypt"."senticrypt_table"
)
SELECT
"timestamp",
COUNT("timestamp")
FROM a
GROUP BY 1 
HAVING COUNT("timestamp") > 1



NULL

SELECT
"timestamp",
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
FROM "senticrypt"."senticrypt_table"
WHERE "timestamp" = null





