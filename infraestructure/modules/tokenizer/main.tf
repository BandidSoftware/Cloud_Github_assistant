variable "enviroment" {
  description = "Wich enviroment is being build"
}

variable "eventBus_name" {}

variable "eventBus_arn" {}

variable "tokensdb_arn" {}

resource "aws_s3_bucket" "code_files" {
  bucket = "code-files"
}

module "role_creation"{
  source = "./role_creation"
  environment = var.enviroment
  eventBus_arn = var.eventBus_arn
  lambda_function_name = "tokenizer"
  code_files_bucket = aws_s3_bucket.code_files.arn
  tokensdb_arn = var.tokensdb_arn
}

resource "aws_cloudwatch_log_group" "function_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.tokenizer.function_name}"
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_iam_role_policy" "tokenizer_logging_policy" {
  name   = "function-logging-policy"
  role = module.role_creation.role_id
  depends_on = [module.role_creation]
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_lambda_function" "tokenizer" {
  function_name = "tokenizer"
  role          = module.role_creation.role_arn
  runtime = "python3.8"
  handler = "testLambda.lambda_handler" //todo despliegue
  filename = "./code/testLambda.zip"
  publish = true
  environment {
    //Aqui pones variables de entorno mamawebo
  }
}

resource "aws_lambda_permission" "tokenizer_allow_s3" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.tokenizer.function_name
  principal     = "s3.amazonaws.com"
  source_arn = aws_s3_bucket.code_files.arn
}

resource "aws_s3_bucket_notification" "code_files_notification" {
  bucket = aws_s3_bucket.code_files.id
  eventbridge = true
  lambda_function {
    events = ["s3:ObjectCreated:*"]
    lambda_function_arn = aws_lambda_function.tokenizer.arn
    filter_suffix = ".py" //Solo se activa con archivos .py
  }
  depends_on = [aws_lambda_function.tokenizer]
}
