module "databases_creation" {
  source = "databases_creation"
  environment = var.environment
}

module "role_creation" {
  source = "role_creation"
  environment = var.environment
  tokensdb_arn = module.databases_creation.tokensDB_arn
  usersdb_arn = module.databases_creation.usersDB_arn
}

resource "aws_lambda_function" "databaseManager" {
  function_name = "database-manager"
  role          = module.role_creation.role_arn
  runtime = "python3.8"
  handler = //todo definir despliegue de las lambdas y variables de entorno
}

resource "aws_cloudwatch_event_rule" "database_operation_rule" {
  name = "database-operation-rule"
  event_bus_name = var.eventBus_name

  event_pattern = jsonencode(
    {
      "source" : ["aws.lambda"],
      "detail-type": ["database-operation"],
      "detail" : {
        "operation" : ["add", "retrieve", "update", "delete"],
        "id" : ["$string"],
        "data" : ["$string"]
      }
    }
  )
}

resource "aws_cloudwatch_event_target" "database_manager_target" {
  arn  = aws_lambda_function.databaseManager.arn
  rule = aws_cloudwatch_event_rule.database_operation_rule.name
  target_id = "database-manager"
}

