variable "environment" {
  description = "Wich enviroment is being build"
}
variable "eventBus_arn" {}
variable "tokensdb_arn" {}

module "role_creation" {
  source = "./role_creation"
  environment = var.environment
  eventBus_arn = var.eventBus_arn
  tokensdb_arn = var.tokensdb_arn
}

resource "aws_cloudwatch_log_group" "function_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.metrics.function_name}"
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_iam_role_policy" "metrics_logging_policy" {
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

resource "aws_lambda_function" "metrics" {
  function_name = "metrics"
  role          = module.role_creation.role_arn
  runtime = "python3.8"
  handler = "testLambda.lambda_handler" //todo despliegue
  filename = "./code/testLambda.zip"

}

resource "aws_lambda_permission" "allow_api_invoke_metrics" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.metrics.function_name
  principal     = "apigateway.amazonaws.com"
}

output "metrics_lambda" {value = aws_lambda_function.metrics.invoke_arn}
