resource "aws_api_gateway_rest_api" "root" {
  name = "root"
  description = "Communications with the root of the app"
}

module "metrics_endpoint" {
  source = "./metrics_endpoint"
  api_rest = aws_api_gateway_rest_api.root.id
  api_rest_parent = aws_api_gateway_rest_api.root.root_resource_id
  metrics_lambda = var.metrics_lambda
}

module "sugestion_endpoint" {
  source = "./sugestions_endpoint"
  api_rest = aws_api_gateway_rest_api.root.id
  api_rest_parent = aws_api_gateway_rest_api.root.root_resource_id
  sugestions_lambda = var.sugester_lambda
}

output api_rest_id {
  value = aws_api_gateway_rest_api.root.id
}

