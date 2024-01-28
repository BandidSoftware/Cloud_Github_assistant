variable "api_rest" {
  name = "api_rest"
}
variable "api_rest_parent" {
  name = "api_rest_parent"
}
variable "sugestions_lambda" {}

resource "aws_api_gateway_resource" "sugestions_endpoint" {
  parent_id   = var.api_rest_parent
  path_part   = "sugestions"
  rest_api_id = var.api_rest
}

resource "aws_api_gateway_method" "get_sugestion" {
  name = "get-sugestion"
  authorization = "NONE" //Decir que a futuro deberia de haber tokens
  http_method = "GET"
  resource_id = aws_api_gateway_resource.sugestions_endpoint.id
  rest_api_id = var.api_rest
}

resource "aws_api_gateway_integration" "lambda_integration" {
  http_method = aws_api_gateway_method.get_sugestion.http_method
  resource_id = aws_api_gateway_resource.sugestions_endpoint.id
  rest_api_id = var.api_rest
  type        = "AWS_PROXY"
  uri = var.sugestions_lambda.invoke_arn
  depends_on = [var.sugestions_lambda]
}

output "endpoint" {
  value = aws_api_gateway_resource.sugestions_endpoint.id
}

output "get_method" {
  value = aws_api_gateway_method.get_sugestion.id
}