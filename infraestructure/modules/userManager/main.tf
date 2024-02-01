module "rol_creation" {
  source = "./role_creation"
  environment = var.environment
  eventBus_arn = var.eventBus_arn
}

resource "aws_lambda_function" "user_manager" {
  function_name = "user-manager"
  role          = module.rol_creation.role_arn
  runtime = "python3.8"
  handler = "testLambda.lambda_handler" //todo despliegue
  filename = "./code/testLambda.zip"
}

resource "aws_lambda_permission" "allow_api_invoke_user_manager" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.user_manager.function_name
  principal     = "apigateway.amazonaws.com"
}