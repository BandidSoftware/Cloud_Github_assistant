module "EventBridge_Datalake" {
  source = "modules/eventBridge"
  environment = var.environment
}

module "Database_Manager" {
  source = "modules/databaseManager"
  environment = var.environment
  account = var.account
  region = var.region
  eventBus_arn = module.EventBridge_Datalake.eventBus_arn
  eventBus_name = module.EventBridge_Datalake.eventBus_name
}