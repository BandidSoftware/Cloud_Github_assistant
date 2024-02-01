variable "environment" {
  description = "Wich enviroment is being build"
}

variable "eventBus_arn" {}
variable "code_files_bucket_arn" {}

resource "aws_s3_bucket" "models_bucket" {
  bucket = "models-bucket"
}

module "role_creation" {
  source = "./role_creation"
  environment = var.environment
  eventBus_arn = var.eventBus_arn
  models_bucket_arn = aws_s3_bucket.models_bucket.arn
  code_files_bucket_arn = var.code_files_bucket_arn
}

resource "aws_lambda_function" "train_sugester" {
  function_name = "train-sugester"
  role          = module.role_creation.role_arn
  runtime = "python3.8"
  handler = "Lambda_handler.lambda_handler"
  filename = "./code/train.zip"
}

resource "aws_cloudwatch_log_group" "function_log_group" {
  name              = "/aws/lambda/sugester"
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_iam_role_policy" "sugester_logging_policy" {
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

resource "aws_cloudwatch_event_rule" "train_schedule" {
  name                = "train-schedule"
  schedule_expression = "cron(0 2 * * ? *)"  # Esta expresión indica que se ejecute a las 2 am UTC todos los días por si quieres cambiar esto pa probarlo
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.train_schedule.name
  target_id = "target-lambda"

  arn = aws_lambda_function.train_sugester.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.train_sugester.function_name
  principal     = "events.amazonaws.com"

  source_arn = aws_cloudwatch_event_rule.train_schedule.arn
}

resource "aws_lambda_function" "get_sugestion" {
  function_name = "get-sugestion"
  role          = module.role_creation.role_arn
  runtime = "python3.8"
  handler = "testLambda.lambda_handler" //todo despliegue
  filename = "./code/testLambda.zip"
}

resource "aws_lambda_permission" "allow_api_invoke_get_sugestion" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_sugestion.function_name
  principal     = "apigateway.amazonaws.com"
}

output "get_sugestion_lambda" {
  value = aws_lambda_function.get_sugestion.invoke_arn
}
