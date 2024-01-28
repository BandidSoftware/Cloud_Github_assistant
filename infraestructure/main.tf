module "EventBridge_Datalake" {
  source = "./modules/eventBridge"
  environment = var.environment
}

module "Database_Manager" {
  source = "./modules/databaseManager"
  environment = var.environment
  eventBus_arn = module.EventBridge_Datalake.eventBus_arn
  eventBus_name = module.EventBridge_Datalake.eventBus_name
}

module "tokenizer" {
  source = "./modules/tokenizer"
  environment = var.environment
  eventBus_arn = module.EventBridge_Datalake.eventBus_arn
}

module  "metrics"{
  source = "./modules/metrics"
  environment = var.environment
  eventBus_arn = module.EventBridge_Datalake.eventBus_arn
}

module "userManager" {
  source = "./modules/userManager"
  environment = var.environment
  eventBus_arn = module.EventBridge_Datalake.eventBus_arn
}

module "sugester" {
  source = "./modules/sugester"
  environment = var.environment
  eventBus_arn = module.EventBridge_Datalake.eventBus_arn
}

module "apiGateWay" {
  source = "./modules/apiGateWay"
  stage = "test"
  metrics_lambda = module.metrics.metrics_lambda
  userOperations_lambda = module.userManager.userManager_invoke
  sugester_lambda = module.sugester.get_sugestion_lambda
}
