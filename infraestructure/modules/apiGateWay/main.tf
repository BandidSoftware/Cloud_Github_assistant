resource "aws_api_gateway_rest_api" "front" {
  name = "front"
  description = "Communications with the front of the app"
}

module "metrics_endpoint" {
  source = "./metrics_endpoint"
  api_rest = aws_api_gateway_rest_api.front.id
  api_rest_parent = aws_api_gateway_rest_api.front.root_resource_id
  metrics_lambda = var.metrics_lambda
}

module "sugestion_endpoint" {
  source = "./sugestions_endpoint"
  api_rest = aws_api_gateway_rest_api.front.id
  api_rest_parent = aws_api_gateway_rest_api.front.root_resource_id
  sugestions_lambda = var.sugester_lambda
}

module "users_endpoint" {
  source = "./users_endpoint"
  api_rest = aws_api_gateway_rest_api.front.id
  api_rest_parent = aws_api_gateway_rest_api.front.root_resource_id
  user_manager_lambda = var.userOperations_lambda
}


