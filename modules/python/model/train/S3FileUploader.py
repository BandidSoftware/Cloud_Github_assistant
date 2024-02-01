import boto3
from botocore.exceptions import NoCredentialsError

class S3FileUploader():

    def __init__(self, local_file_path, s3_bucket, s3_key):
        self.local_file_path = local_file_path
        self.s3_bucket = s3_bucket
        self.s3_key = s3_key

    def upload_to_s3(self, local_file_path):
        s3 = boto3.client('s3')

        try:
            s3.upload_file(self.local_file_path, self.s3_bucket, self.s3_key)
            print(f"Model uploaded to S3 bucket: {self.s3_bucket} with key: {self.s3_key}")
        except FileNotFoundError:
            print(f"The file {local_file_path} was not found.")
        except NoCredentialsError:
            print("Credentials not available or not valid.")