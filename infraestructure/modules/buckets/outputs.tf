output "bucket_names" {
  value = [
    aws_s3_bucket.datalake.bucket,
    aws_s3_bucket.code_files.bucket,
    aws_s3_bucket.artifacts.bucket,
  ]
}
