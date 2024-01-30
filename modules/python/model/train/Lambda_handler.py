import subprocess
import json
import boto3
import shutil
import os

def lambda_handler(event, context):
    # Extraer los parámetros del evento
    file_path = event.get('file_path', '')
    model_name = event.get('model_name', '')

    # Comando para invocar el contenedor
    command = f"docker run -v {os.getcwd()}:/app/shared -e FILE_PATH={file_path} -e MODEL_NAME={model_name} nombre-del-imagen"

    try:
        # Ejecutar el comando y capturar la salida
        result = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
        output = result.decode('utf-8').strip()
        print(output)

        # Copiar el modelo a S3
        s3 = boto3.client('s3')
        s3.upload_file(f'{os.getcwd()}/{model_name}.joblib', 'nombre-del-bucket', 'ruta/en/s3/{model_name}.joblib')

        return {
            'statusCode': 200,
            'body': json.dumps({'result': output})
        }
    except subprocess.CalledProcessError as e:
        # Capturar errores de ejecución del contenedor
        print(f"Error: {e.output.decode('utf-8').strip()}")
        return {
            'statusCode': 500,
            'body': json.dumps({'error': 'Error en la ejecución del contenedor'})
        }
































from modules.python.DBManagers.DynamoDBManager import DynamoDBManager
from modules.python.tokenize.python_tokenizer.PyTokenizer import PyTokenizer
from modules.python.tokenize.utils.JSONDeserializer import JSONDeserializer
from modules.python.tokenize.utils.JSONSerializer import JSONSerializer
from modules.python.utils.utils import S3FileRetriever


# source_code = "{\"name\": \"code.py\", \"code\": \"import math\\nimport numpy as np\\n\\ndef calcular_distancia(x,
# y):\\n    return math.sqrt(x**2 + y**2)\\n\\npunto_a = (3, 4)\\nresultado = calcular_distancia(
# *punto_a)\\n\\nprint(resultado)\\n\" , \"id\": \"r3tfgcv\"}"


def lambda_handler(event, context):

    source_code = S3FileRetriever().get_response(event)

    josn_data = JSONDeserializer().deserialize(source_code)
    tokens = PyTokenizer().tokenize(josn_data.code)
    serialized_json = JSONSerializer().serialize(tokens, josn_data.user_id, josn_data.name)

    DynamoDBManager("us-east-1", " tokens-datamart").add_item(serialized_json)

