import json

from DBManagers import DynamoDBManager


def dbManagerhandler(event, context):
    print('Event received: ' + json.dumps(event, indent=2))

    data, operation, region, table_name = parse_event(event)

    manager = DynamoDBManager(region, table_name)

    if operation == 'add':
        response = manager.add_item(data)
    elif operation == 'retrieve':
        id_to_retrieve = data.get('id', '')
        response = manager.retrieve_item(id_to_retrieve)
    elif operation == 'update':
        id_to_update = data.get('id', '')
        update_attribute = data.get('update_attribute', '')
        update_value = data.get('update_value', '')
        response = manager.update_item(id_to_update, update_attribute, update_value)
    elif operation == 'delete':
        id_to_delete = data.get('id', '')
        response = manager.delete_item(id_to_delete)
    else:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'Invalid operation'})
        }

    return {
        'statusCode': 200,
        'body': json.dumps({'response': response})
    }


def parse_event(event):
    operation = event.get('operation', '')
    data = event.get('data', {})
    region = event.get('region', '')
    table_name = event.get('table_name', '')
    return data, operation, region, table_name
