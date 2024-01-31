variable "api_rest" {}

variable "api_rest_parent" {}

variable "sugestions_lambda" {}

resource "aws_api_gateway_resource" "sugestions_endpoint" {
  parent_id   = var.api_rest_parent
  path_part   = "sugestions"
  rest_api_id = var.api_rest
}

resource "aws_api_gateway_method" "get_sugestion" {
  authorization = "NONE" //Decir que a futuro deberia de haber tokens
  http_method = "GET"
  resource_id = aws_api_gateway_resource.sugestions_endpoint.id
  rest_api_id = var.api_rest
}

resource "aws_api_gateway_integration" "get_sugestion_integration" {
  http_method = aws_api_gateway_method.get_sugestion.http_method
  resource_id = aws_api_gateway_resource.sugestions_endpoint.id
  rest_api_id = var.api_rest
  type        = "AWS_PROXY"
  uri = var.sugestions_lambda
  integration_http_method = "GET"
}

output "endpoint" {
  value = aws_api_gateway_resource.sugestions_endpoint.id
}

output "get_method" {
  value = aws_api_gateway_method.get_sugestion.id
}

output "integration" {
  value = aws_api_gateway_integration.get_sugestion_integration.id
}