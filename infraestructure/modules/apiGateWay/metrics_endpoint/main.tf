variable "api_rest" {
  name = "api_rest"
}
variable "api_rest_parent" {
  name = "api_rest_parent"
}

resource "aws_api_gateway_resource" "metrics_endpoint" {
  parent_id   = var.api_rest_parent
  path_part   = "metrics"
  rest_api_id = var.api_rest
}

resource "aws_api_gateway_method" "get_metrics" {
  name = "get-metrics"
  authorization = "NONE" //Decir que a futuro deberia de haber tokens
  http_method = "GET"
  resource_id = aws_api_gateway_resource.metrics_endpoint.id
  rest_api_id = var.api_rest
}

output "endpoint" {
  value = aws_api_gateway_resource.metrics_endpoint.id
}

output "get_method" {
  value = aws_api_gateway_method.get_metrics.id
}