module "role_creation" {
  source = "role_creation"
  environment = var.environment
  eventBus_arn = var.eventBus_arn
}

resource "aws_lambda_function" "metrics" {
  function_name = "metrics"
  role          = module.role_creation.role_arn
  handler = //todo esperar al despliegue como no
}

resource "aws_lambda_permission" "allow_api_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.metrics.function_name
  principal     = "apigateway.amazonaws.com"
}
