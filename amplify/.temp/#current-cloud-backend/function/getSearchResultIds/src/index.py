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
        # TODO: make sure empty results are shown last
        # the return cases are as follows: one subcategory id is given --> return all ids
        # one main category id is given: return all subcategory ids
        # many subcategory ids are given --> return ids for them
        # TODO: check if given id is a main category, in this case automatically return the subcategories
    
        'body': json.dumps({"searchResultIds": {
            "8063ce0b-3645-4fcb-8445-f9ea23243e78": ["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
                                                     "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
                                                     "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
                                                     "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
                                                     "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
                                                     "1", "1", "1", "1", "1", "1", "1", ],
            "8063ce0b-3645-4fcb-8445-f9ea23243e83": ["1", "1", "1", "1", "1", "1", "1", "1", "1", "1"],
            "8063ce0b-3645-4fcb-8445-f9ea23243e80": ["1", "1", "1", "1", "1", "1", "1", "1", "1", "1"],
            "8063ce0b-3645-4fcb-8445-f9ea23243e65": []}

        })
    }
