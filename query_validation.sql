DEDUP

WITH query AS(
SELECT
b.*
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
datetime,
date(from_iso8601_timestamp(datetime)) AS "date",
date_format(from_iso8601_timestamp(datetime),'%H:%i:%s') AS "hour",
btc_price,
"count",
mean,
median,
"sum",
rate
from "senticrypt"."senticrypt_table") as b
on a.batch = b.batch and a.id = b.id)

select 
id,
COUNT(id)
FROM query
GROUP BY 1 
HAVING COUNT(id) > 1




NULL

WITH query AS(
SELECT
b.*
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
"timestamp" as iagg_ts_id,
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
from "senticrypt"."senticrypt_table") as b
on a.batch = b.batch and a.id = b.id)

select 
*
FROM query
where id is Null
