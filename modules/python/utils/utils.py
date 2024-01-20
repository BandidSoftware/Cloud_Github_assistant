import os

from boto3.session import Session


def retrieveFileFromS3(bucket_name, object_name, download_path):
    session = Session(aws_access_key_id=os.getenv("ACCESS_KEY"),
                      aws_secret_access_key=os.getenv("SECRET_KEY"))
    session.client('s3').download_file(bucket_name, object_name, download_path)
