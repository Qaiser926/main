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
        # TODO: activities have to be sorted in an interesting order
        'body': json.dumps({
            "compingUpEvents": ["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
                                "1", "1", "1", "1"],
            "openActivities": ["1", "1", "1", "1", "1", "1", "1", "1", "1"],
            "popularEA": ["1", "1", "1", "1", "1", "1", "1", "1", "1"],
            "universityEvents": ["1", "1", "1", "1", "1", "1", "1", "1", "1"]
        })
    }