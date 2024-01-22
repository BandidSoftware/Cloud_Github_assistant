resource "aws_iam_role" "S3_lambda_manager_rol" {
  name = "S3-lambda-manager"

  inline_policy {
    name   = "lambda-s3-sqs-policy"
    policy = file("${path.module}/policies/s3_lambda_manager_policy.json")
  }
}

resource "aws_iam_role" "dynamodb_manager_role" {
  name = "dynamodb-manager-role"

  inline_policy {
    name   = "dynamodb-manager-policy"
    policy = file("${path.module}/policies/dynamodb_manager_policy.json")
  }
}

resource "aws_iam_role" "lambda_sqs_role" {
  name = "lambda-sqs-role"

  inline_policy {
    name   = "lambda-sqs-policy"
    policy = file("${path.module}/policies/lambda_sqs_policy.json")
  }
}
