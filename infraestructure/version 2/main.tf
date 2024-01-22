module "EventBridge_Datalake" {
  source = "modules/eventBridge"
  environment = var.environment
}