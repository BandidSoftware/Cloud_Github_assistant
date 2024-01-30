import json


def lambda_handler(event, context):
    # Imprimir el evento recibido
    print("Evento recibido:")
    print(json.dumps(event))

    # Retorna algo si es necesario
    return {
        'statusCode': 200,
        'body': json.dumps('¡Función Lambda ejecutada exitosamente!')
    }
