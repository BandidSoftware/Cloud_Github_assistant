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

resource "aws_api_gateway_method_response" "get_sugestion_response" {
  http_method = "GET"
  resource_id = aws_api_gateway_resource.sugestions_endpoint.id
  rest_api_id = var.api_rest
  status_code = "200"
  response_models = {} //MODELO DE LAS Respuestas Alvaro
}

//Esta en vuestra mano pq es lo q va a devolver la lambda al usuario
//response_models (Optional) A map specifying the model resources used for the response's content type.
//Response models are represented as a key/value map, with a content type as the key and a Model name as the value.
//https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_response <- documentacion
//https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration_response

resource "aws_api_gateway_integration_response" "get_sugestion_integration_response" {
  http_method = "GET"
  resource_id = aws_api_gateway_resource.sugestions_endpoint.id
  rest_api_id = var.api_rest
  status_code = "200" //vuestra mano
  response_templates = {}
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