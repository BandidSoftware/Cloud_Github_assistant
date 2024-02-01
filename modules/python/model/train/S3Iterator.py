import boto3

class S3Iterator:
    def __init__(self, bucket_name, region_name=None):
        self.bucket_name = bucket_name
        self.s3_client = boto3.client('s3', region_name=region_name)

    def list_objects(self):
        response = self.s3_client.list_objects_v2(Bucket=self.bucket_name)
        return response.get('Contents', [])

    def iterate_objects_content(self):
        objects = self.list_objects()
        for obj in objects:
            key = obj['Key']
            content = self.get_object_content(key)
            yield key, content

    def get_object_content(self, key):
        response = self.s3_client.get_object(Bucket=self.bucket_name, Key=key)
        return response['Body'].read().decode('utf-8')
