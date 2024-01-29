import boto3


class S3FileRetriever:
    def __init__(self):
        self.s3_client = boto3.client('s3')

    def get_response(self, event):
        try:
            bucket = self._get_bucket(event)
            key = self._get_key(event)
            response = self.s3_client.get_object(Bucket=bucket, Key=key)
            return self._read_body_content(response)
        except Exception as e:
            print("Error al obtener el objeto:", e)

    def _get_bucket(self, event):
        return event['Records'][0]['s3']['bucket']['name']

    def _get_key(self, event):
        return event['Records'][0]['s3']['object']['key']

    def _read_body_content(self, response):
        body_content = response['Body'].read().decode('utf-8')
        return body_content
