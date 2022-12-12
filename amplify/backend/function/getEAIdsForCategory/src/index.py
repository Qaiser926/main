import json

def handler(event, context):
    # TODO implement logic that for a category id corresponding ids of other event or activities are
  print('received event:')
  print(event)
  
  return {
      'statusCode': 200,
      'headers': {
          'Access-Control-Allow-Headers': '*',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
      },
      'body': json.dumps({'eaIdList': ["dsf", "sfj"]})
  }