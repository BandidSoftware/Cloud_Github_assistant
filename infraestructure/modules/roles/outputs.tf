output "s3_lambda_manager_role_arn" {
  value = aws_iam_role.S3_lambda_manager_rol.arn
}

output "dynamodb_manager_role_arn" {
  value = aws_iam_role.dynamodb_manager_role.arn
}

output "lambda_sqs_role_arn" {
  value = aws_iam_role.lambda_sqs_role.arn
}
