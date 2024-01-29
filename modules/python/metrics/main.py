from modules.python.DBManagerHandler import parse_event
from modules.python.DBManagers.DynamoDBManager import DynamoDBManager
from modules.python.metrics.python_metrics.PyMetrics import PyMetrics
from modules.python.metrics.utils.JSONDeserializer import JSONDeserializer
from modules.python.metrics.utils.JSONSerializer import JSONSerializer

# json_string = '{"id": "r3tfgcv", "name": "code.py", "tokens": ["import", "math", "\\n", "import", "numpy", "as",
# "np", "\\n", "\\n", "def", "calcular_distancia", "(", "x", ",", "y", ")", ":", "\\n", "return", "math", ".",
# "sqrt", "(", "x", "2", "y", "2", ")", "\\n", "\\n", "punto_a", "(", "3", ",", "4", ")", "\\n", "resultado",
# "calcular_distancia", "(", "punto_a", ")", "\\n", "\\n", "print", "(", "resultado", ")", "\\n"]}'

# Json de evento -> {'user-id': 'user-id, 'file-name': 'file-name}


def lambda_handler(event, context):

    user_id, file_name = parse_event(event)
    json_string = DynamoDBManager("us-east-1", " tokens-datamart").retrieve_item(user_id, file_name)

    josn_data = JSONDeserializer().deserialize(json_string)
    metrix = PyMetrics().calculate_metrics(josn_data.tokens)
    serialized_json = JSONSerializer().serialize(metrix, josn_data.user_id, josn_data.name)

    DynamoDBManager("us-east-1", " metrics-datamart").add_item(serialized_json)

