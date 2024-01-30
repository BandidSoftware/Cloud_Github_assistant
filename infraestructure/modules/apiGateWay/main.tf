variable "environment" {}

resource "aws_api_gateway_rest_api" "data_connection" {
  name = "data_connection"
}

module "metrics_endpoint" {
  source = "./metrics_endpoint"
  api_rest = aws_api_gateway_rest_api.data_connection.id
  api_rest_parent = aws_api_gateway_rest_api.data_connection.root_resource_id
  metrics_lambda = var.metrics_lambda
}

module "sugestion_endpoint" {
  source = "./sugestions_endpoint"
  api_rest = aws_api_gateway_rest_api.data_connection.id
  api_rest_parent = aws_api_gateway_rest_api.data_connection.root_resource_id
  sugestions_lambda = var.sugester_lambda
}

resource "aws_api_gateway_deployment" "integration_deploy" {
  rest_api_id = aws_api_gateway_rest_api.data_connection.id

  depends_on = [
      module.metrics_endpoint, module.sugestion_endpoint
    ]

  triggers = {
    redeployment = sha1(jsonencode([
        module.metrics_endpoint.endpoint,
        module.metrics_endpoint.get_method,
        module.metrics_endpoint.integration,
        module.sugestion_endpoint.endpoint,
        module.sugestion_endpoint.get_method,
        module.sugestion_endpoint.integration
    ]))
  }
    lifecycle {
    create_before_destroy = true
}
}


resource "aws_api_gateway_stage" "events_apig_stages" {
  deployment_id = aws_api_gateway_deployment.integration_deploy.id
  rest_api_id   = aws_api_gateway_rest_api.data_connection.id
  stage_name    = var.environment
}

output api_rest_id {
  value = aws_api_gateway_rest_api.data_connection.id
}

