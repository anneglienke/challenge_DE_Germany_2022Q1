CREATE VIEW?

WITH query AS(
SELECT
b.*,
case when b.median > 0 then 'positive'
when b.median = 0 then 'neutral'
when b.median < 0 then 'negative' 
end as median_sentiment
FROM (
select
"timestamp"as agg_ts_id,
max(from_iso8601_timestamp("_sdc_batched_at")) as batch
from "senticrypt"."senticrypt_table"
group by 1
) as a
join (
SELECT
from_iso8601_timestamp("_sdc_batched_at") as batch,
"timestamp" as agg_ts_id,
last,
datetime as datetime_utc,
date(from_iso8601_timestamp(datetime)) AS date_utc,
date_format(from_iso8601_timestamp(datetime),'%H:%i:%s') AS hour_utc,
btc_price,
"count",
mean,
median,
"sum",
rate
from "senticrypt"."senticrypt_table") as b
on a.batch = b.batch and a.agg_ts_id = b.agg_ts_id)

SELECT
agg_ts_id,
datetime_utc,
date(from_iso8601_timestamp(datetime)) as date_utc,
date_format(from_iso8601_timestamp(datetime),'%H:%i:%s') as hour_utc,
btc_price,
"count",
mean,
median,
"sum",
rate,
median_sentiment
FROM query







