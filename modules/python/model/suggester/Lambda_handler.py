import json
from EventParser import EventParser
from app.main import Main
from S3ModelDownloader import S3ModelDownloader

def lambda_handler(event, context):
    model_name, code = EventParser().event_parser(event)
    S3ModelDownloader("us-east-1").download_model("models", model_name, ".")
    class_name = Main(f"{model_name}.joblib", code)
    response_data = {
        'status': 'success',
        'message': 'Proceso completado exitosamente',
        'data': {class_name}
    }
    return {
        'statusCode': 200,
        'body': json.dumps(response_data),
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        }
    }
