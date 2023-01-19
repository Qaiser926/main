import json

def handler(event, context):
  print('received event:')
  print(event)

  # first, do safety check to see if user id fits with session ID
  # the event can be either created or updated
  # the first step is to check in which case we are by checking if the eAId is already in the database
  # if an event was found in the database, check if it belongs to the user, if not send an error code back
  # in both cases, modifying and adding, initialize an event or activity from datamodels, then send it to the middle layer

  return {
      'statusCode': 200,
      'headers': {
          'Access-Control-Allow-Headers': '*',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
      },
      'body': json.dumps({})
  }
