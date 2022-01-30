from stitchclient.client import Client
import os
import requests
import json
from datetime import datetime


with Client(
    os.environ['STITCH_CLIENT_ID'],
    os.environ['STITCH_TOKEN'],
    os.environ['STITCH_REGION'],
    callback_function=print,
) as client:

    response = requests.get("https://api.senticrypt.com/v1/bitcoin.json")
    data = response.text
    json_dic = json.loads(data)

    for item in json_dic:
        # print(item)
        client.push({
            'action': 'upsert',
            'table_name': 'senticrypt-table',
            'key_names': ['timestamp'],
            'sequence': int(item['timestamp']),
            'data': {
                'timestamp': item['timestamp'],
                'datetime': datetime.fromtimestamp(item['timestamp']).isoformat(),
                'count': item['count'],
                'mean': item['mean'],
                'median': item['median'],
                'btc_price': item['btc_price'],
                'last': item['last'],
                'sum': item['sum'],
                'rate': item['rate']
            },
        }, item)



