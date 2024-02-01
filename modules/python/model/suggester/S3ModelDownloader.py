import boto3

class S3ModelDownloader:
    def __init__(self, region_name=None):
        self.s3_client = boto3.client('s3', region_name=region_name)

    def download_model(self, bucket_name, object_key, local_file_path):
        try:
            self.s3_client.download_file(bucket_name, object_key, local_file_path)
            print(f"File downloaded successfully: {local_file_path}")
        except Exception as e:
            print(f"Error downloading file from S3: {e}")
