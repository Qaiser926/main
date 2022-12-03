import json


def handler(event, context):
    print('received event:')
    print(event)
    openingTime = [{'weekday_id': 1, 'is_open': True, 'time': '1000'},
                   {'weekday_id': 1, 'is_open': False, 'time': '1100'},
                   {'weekday_id': 1, 'is_open': True, 'time': '0800'},
                   {'weekday_id': 1, 'is_open': False, 'time': '0930'},
                   {'weekday_id': 1, 'is_open': True, 'time': '1900'},
                   {'weekday_id': 1, 'is_open': False, 'time': '2130'},
                   {'weekday_id': 4, 'is_open': True, 'time': '0800'},
                   {'weekday_id': 4, 'is_open': False, 'time': '0930'}]
    openingTime = getOpeningTimesDict(openingTimes=openingTime)

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Headers': '*',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
        },
        'body': json.dumps({'title': 'Hello from your new Amplify Python lambda no no no no!', 'id': 'i am id',
                            'description': 'i am description', 'locationTitle': 'loctitle', 'locationId': "loc_id",
                            'price': 12.12, 'latitude': 54.324486, 'longitude': 10.1383,
                            'categoryId': '8063ce0b-3645-4fcb-8445-f9ea23243e85', "ownerId": "ownerId",
                            "isOnline": False, 'openingTime': openingTime})
    }



def getOpeningTimesDict(openingTimes: list):
    openingTimesDict = {1: [], 2: [], 3: [], 4: [], 5: [], 6: [], 7: []}
    alwaysOpen = True
    for openingHourElement in openingTimes:
        notInserted = True
        for i in range(len(openingTimesDict[openingHourElement['weekday_id']])):
            if (not openingHourElement['is_open']):
                alwaysOpen = False
            if float(openingHourElement['time']) < float(
                    openingTimesDict[openingHourElement['weekday_id']][i]['time']):
                # might need to add up hours and minutes to a minute sum for comparison
                openingTimesDict[openingHourElement['weekday_id']].insert(i, openingHourElement)
                notInserted = False
                break

        if (notInserted):
            openingTimesDict[openingHourElement['weekday_id']].append(openingHourElement)

    if (alwaysOpen):
        for key, value in openingTimesDict.items():
            openingTimesDict[key] = [[0, 0]]
    else:
        for key, value in openingTimesDict.items():
            global_temp_list = []
            temp_list = []
            for j in range(len(value)):
                if len(temp_list) == 2:
                    global_temp_list.append(temp_list)
                    temp_list = []
                temp_list.append(float(value[j]['time']))
            if len(temp_list):
                global_temp_list.append(temp_list)
            if len(global_temp_list):
                openingTimesDict[key] = global_temp_list
            else:
                openingTimesDict[key] = None
    return openingTimesDict
