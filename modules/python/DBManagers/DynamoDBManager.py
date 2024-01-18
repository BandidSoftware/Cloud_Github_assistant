import boto3


class DynamoDBManager:

    def __init__(self, region_name, table_name):
        self.db = boto3.resource('dynamodb', region_name=region_name)
        self.table = self.db.Table(table_name)

    def add_item(self, item):
        response = self.table.put_item(Item=item)
        print('Item added:', response)

    def retrieve_item(self, id):
        key = {'ID': id}
        response = self.table.get_item(Key=key)
        item = response.get('Item')
        if item:
            print('Retrieved item: ', item)
        else:
            print('Item not found')

    def update_item(self, id, update_atribute, update_value):
        key = {'ID': id}
        update_expression = f'SET {update_atribute} = :{update_atribute}'
        attribute_values = {f':{update_atribute}': update_value}

        response = self.table.update_item(
            Key=key,
            UpdateExpression=update_expression,
            ExpressionAtrributeValues=attribute_values
        )

        print('Updated item:', response)

    def delete_item(self, id):
        key = {'ID': id}

        response = self.table.delete(key)
        print('Item deleted:', response)