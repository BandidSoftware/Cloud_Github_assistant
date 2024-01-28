module "rol_creation" {
  source = "role_creation"
  environment = var.environment
  eventBus_arn = var.eventBus_arn
}

resource "aws_lambda_function" "user_manager" {
  function_name = "user-manager"
  role          = module.rol_creation.role_arn
  handler =  //todo configurar cuando despliegues
}

resource "aws_lambda_permission" "allow_api_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.user_manager.function_name
  principal     = "apigateway.amazonaws.com"
}