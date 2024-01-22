output "bucket_names" {
  value = [
    aws_s3_bucket.git-radar-code-files.bucket,
    aws_s3_bucket.git-radar-datalake.bucket,
    aws_s3_bucket.git-radar-source-code.bucket,
  ]
}
