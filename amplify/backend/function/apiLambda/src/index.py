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
        'body': json.dumps({'title': 'Hello from your new Amplify Python lambda no no no no!', 'id': 'i am id',
                            'description': 'i am description', 'locationTitle': 'loctitle', 'locationId': "loc_id",
                            'price': 12.12, 'latitude': 54.324486, 'longitude': 10.1383, 'categoryId': '8063ce0b-3645-4fcb-8445-f9ea23243e85', "ownerId": "ownerId", "isOnline": False})
    }
