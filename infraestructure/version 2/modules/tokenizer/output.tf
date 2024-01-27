output "code_files_s3_arn" {
  value = aws_s3_bucket.code_files.arn
}

output "tokenizer_lambda" {
  value = aws_lambda_function.tokenizer.arn
}