output "bucket_names" {
  value = [
    aws_s3_bucket.git-radar-code-files.arn,
    aws_s3_bucket.git-radar-datalake.arn,
    aws_s3_bucket.git-radar-source-code.arn,
  ]
}
