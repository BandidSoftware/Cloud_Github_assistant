from S3Iterator import S3Iterator
from S3FileUploader import S3FileUploader
from JsonDeserializer import JsonDeserializer
from app.main import Main
from AppendToFile import AppendToFile


def lambda_handler(event, context):

    file = "code.py"
    id_user = None
    s3_iterator = S3Iterator(bucket_name='tu_bucket')
    for _, obj_content in s3_iterator.iterate_objects_content():
        id_user, _, code = JsonDeserializer().deserializer(obj_content)
        AppendToFile(file).append_string(code)
    Main(file, id_user).main()
    S3FileUploader(f"{id_user}.jolib", "models-buckets", id_user)
