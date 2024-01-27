resource "aws_api_gateway_rest_api" "front" {
  name = "front"
  description = "Communications with the front of the app"
}

module "metrics_endpoint" {
  source = "metrics_endpoint"
  api_rest = aws_api_gateway_rest_api.front.id
  api_rest_parent = aws_api_gateway_rest_api.front.root_resource_id
}

module "sugestion_endpoint" {
  source = "sugestions_endpoint"
  api_rest = aws_api_gateway_rest_api.front.id
  api_rest_parent = aws_api_gateway_rest_api.front.root_resource_id
}

module "" {
  source = ""
}
resource "aws_api_gateway_method" "get_suggestion" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource
  rest_api_id   = ""
}


resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [] //todo depende de los metodos xD
  rest_api_id = aws_api_gateway_rest_api.front.id
  stage_name = var.stage
}

