variable "lambda_function_name" {}

variable "tokensdb_arn" {}

variable "environment" {
  description = "Wich enviroment is being build"
}

variable "code_files_bucket" {}

variable "eventBus_arn" {}

resource "aws_iam_role" "tokenizer_rol" {
  name = "${var.lambda_function_name}-role"  # Nombre del rol

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        "Action": "sts:AssumeRole",
        "Principal": { "Service": "lambda.amazonaws.com"
        },
     "Effect": "Allow",
     "Sid": ""
      },
      {
        Action   : ["s3:GetObject", "events:PutEvents", "dy"],
        Effect   : "Allow",
        Resource : [var.code_files_bucket, var.eventBus_arn]
      },
      {
        Action   = ["dynamodb:Scan", "dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:UpdateItem", "dynamodb:DeleteItem"],
        Effect   = "Allow",
        Resource = [var.tokensdb_arn]
      }
    ]
  })
}

output "role_arn" {
  value = aws_iam_role.tokenizer_rol.arn
}

output "role_id" {
  value = aws_iam_role.tokenizer_rol.id
}