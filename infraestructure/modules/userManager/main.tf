module "rol_creation" {
  source = "role_creation"
  environment = var.environment
  eventBus_arn = var.eventBus_arn
}

resource "aws_lambda_function" "user_manager" {
  function_name = "user-manager"
  role          = module.rol_creation.role_arn
  handler =  //todo configurar cuando despliegues
}

//todo montar las operaciones de usuario