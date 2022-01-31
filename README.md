# Nuri Coding Challenge <img align="right" width="100" height="100" src="images/logo.jpeg">
<br />

## The challenge

The challenge was to write a Python script to pull market sentiment data from [SentiCrypt API](https://senticrypt.com/) and push it to [Stitch Import API](https://www.stitchdata.com/docs/developers/import-api/). Then write a SQL query to transform this data into a format useful for the BI Analysts. <br /><br />

## The solution

I chose to use AWS Lambda Container Funtion triggered hourly by AWS EventBridge to run a Docker Image stored on AWS ECR. This image contains a Python script that pulls data from SentiCrypt API and pushes it to Stitch Import. Stitch then does the upsert and loads the data to a AWS S3 bucket. The data is then crawled by AWS Glue Crawler, which will create a Data Catalog that enables it to be queried by AWS Athena. <br /><br />

![Solution's Archictecture](images/architecture.jpeg)

<br /><br />
## Replicating the solution 

To run the [Dockerfile](Dockerfile) locally, create a .env file with these environment variables:<br />


```
STITCH_CLIENT_ID = 
STITCH_TOKEN = 
STITCH_REGION = 
```

Stich region should be either 'eu' or 'us'. For more information on how to set the environment, check the [Stitch Documentation](https://www.stitchdata.com/docs/developers/import-api/guides/quick-start).
<br /><br />

## Important assumptions and decisions made

>> obs: upsert based on timestamp; validation (check if makes sense); add datetime to push; query: check duplicates and null (timestamp)
>> query.sql = ?
>> docker-compose.yml = ?
