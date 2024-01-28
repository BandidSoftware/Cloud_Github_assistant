module "role_creation" {
  source = "role_creation"
  environment = var.environment
  eventBus_arn = var.eventBus_arn
}

resource "aws_lambda_function" "train_sugester" {
  function_name = "train-sugester"
  role          = module.role_creation.role_arn
  handler = //configurar
}

resource "aws_lambda_permission" "allow_api_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.train_sugester.function_name
  principal     = "apigateway.amazonaws.com"
}

resource "aws_lambda_function" "get_sugestion" {
  function_name = "get-sugestion"
  role          = module.role_creation.role_arn
  handler = //configurar
}

resource "aws_lambda_permission" "allow_api_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_sugestion.function_name
  principal     = "apigateway.amazonaws.com"
}