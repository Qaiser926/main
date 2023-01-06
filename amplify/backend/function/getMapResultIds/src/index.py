import json


def handler(event, context):
    print('received event:')
    print(event)

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Headers': '*',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
        },
        'body': json.dumps({
            "activityResults": [{"id": "1", "coordinates": {"latitude": 54.323334, "longitude": 10.139444}},
                                  {"id": "1", "coordinates": {"latitude": 54.3234, "longitude": 10.13945}},
                                  {"id": "1", "coordinates": {"latitude": 54.32345, "longitude": 10.13944544}},
                                  {"id": "1", "coordinates": {"latitude": 54.323364, "longitude": 10.139494}},
                                  {"id": "1", "coordinates": {"latitude": 54.325334, "longitude": 10.131444}},],
            "eventResults": [{"id": "1", "coordinates": {"latitude": 54.323364, "longitude": 10.139494}},
                                  {"id": "1", "coordinates": {"latitude": 54.325334, "longitude": 10.131444}},
                             {"id": "1", "coordinates": {"latitude": 54.323564, "longitude": 10.139994}},
                             {"id": "1", "coordinates": {"latitude": 54.325034, "longitude": 10.131044}}
                             ],

        })
    }
