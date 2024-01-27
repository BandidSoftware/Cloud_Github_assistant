variable "api_rest" {
  name = "api_rest"
}
variable "api_rest_parent" {
  name = "api_rest_parent"
}

resource "aws_api_gateway_resource" "users_endpoint" {
  parent_id   = var.api_rest_parent
  path_part   = "users"
  rest_api_id = var.api_rest
}

resource "aws_api_gateway_method" "get_user" {
  name = "get-user"
  authorization = "NONE" //Decir que a futuro deberia de haber tokens
  http_method = "GET"
  resource_id = aws_api_gateway_resource.users_endpoint.id
  rest_api_id = var.api_rest
}

resource "aws_api_gateway_method" "put_user" {
  name = "put-user"
  authorization = "NONE" //Decir que a futuro deberia de haber tokens
  http_method = "PUT"
  resource_id = aws_api_gateway_resource.users_endpoint.id
  rest_api_id = var.api_rest
}

resource "aws_api_gateway_method" "delete_user" {
  name = "delete-user"
  authorization = "NONE" //Decir que a futuro deberia de haber tokens
  http_method = "DELETE"
  resource_id = aws_api_gateway_resource.users_endpoint.id
  rest_api_id = var.api_rest
}

output "endpoint" {
  value = aws_api_gateway_resource.users_endpoint.id
}

output "get_method" {
  value = aws_api_gateway_method.get_user.id
}

output "put_method" {
  value = aws_api_gateway_method.put_user.id
}

output "delete_method" {
  value = aws_api_gateway_method.delete_user.id
}