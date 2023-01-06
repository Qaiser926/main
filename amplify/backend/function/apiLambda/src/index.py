import json
import datetime

photo_binary = b'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'.decode(
    'ascii')

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
    prices = [1.0, 5.0, 10.0]
    prices = getPrices(prices=prices)

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Headers': '*',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
        },
        #TOdO include attributions and html "attribution": "google"
        'body': json.dumps({'title': 'Hello from your new Amplify Python lambda no no no no!', 'id': 'i-am-id',
                            'description': 'i am description', "photos" : [photo_binary],

                            'categoryId': '8063ce0b-3645-4fcb-8445-f9ea23243e85', "ownerId": "ownerId",
                            "isOnline": False,
                            # TODO include to database
                            "searchEnhancement": {"cognitiveLevel": 2, "physicalLevel": 0, "socialLevel": None,
                                                  "singlePersonEligibility": None, "coupleEligibility": 3,
                                                  "friendGroupEligibility": 0, "professionalEligibility": None},
                            # states if the user's profile is shown --> add to database
                            "ownerIsOrganizer": True,
                             "prices": prices,
                            "location": {"isOnline": False, "city": "Kiel", "streetNumber": "100",
                                         "locationTitle": 'Die Pumpe', "street": "abc street", 'locationId': "loc_id", "postalCode": "12345",
                                         'latitude': 54.324486, 'longitude': 10.1383, }, "time": {"startTimeUtc": str(datetime.datetime(year=2022, month=12, day=12, hour=12, minute=00)),
                            "endTimeUtc": str(datetime.datetime(year=2022, month=12, day=12, hour=12, minute=30)), 'openingTime': openingTime}, })
    }


def getPrices(prices: list):
    if len(prices) > 2:
        return [min(prices), max(prices)]


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
