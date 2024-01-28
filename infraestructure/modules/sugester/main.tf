module "role_creation" {
  source = "./role_creation"
  environment = var.environment
  eventBus_arn = var.eventBus_arn
}

resource "aws_lambda_function" "train_sugester" {
  function_name = "train-sugester"
  role          = module.role_creation.role_arn
  runtime = "python3.8"
  handler = "testLambda.lambda_handler" //todo despliegue
  filename = "./code/testLambda.zip"

}
//todo configurar schedule train

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