# nuri-coding-challenge

>> to run push.py: create .env file with STITCH_CLIENT_ID = 
STITCH_TOKEN = 
STITCH_REGION = 
regions: 'eu' or 'us''
more: stitch documentation

>> deploy: lambda container function with EventBridge trigger set to execute hourly; s3 accesible via Athena

>> obs: upsert based on timestamp; validation (check if makes sense); add datetime to push; query: check duplicates and null (timestamp)