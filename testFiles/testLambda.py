def lambda_handler(event, context):
    # Imprimir el evento recibido
    print("Evento recibido:", event)

    # Devolver una respuesta (opcional)
    return {
        'statusCode': 200,
        'body': 'Evento recibido correctamente'
    }
