module "EventBridge_Datalake" {
  source = "./modules/eventBridge"
  environment = var.environment
}

module "databases" {
  source = "./modules/databases_creation"
  enviroment = var.environment
}

module "tokenizer" {
  source = "./modules/tokenizer"
  enviroment = var.environment
  eventBus_arn = module.EventBridge_Datalake.eventBus_arn
  eventBus_name = module.EventBridge_Datalake.eventBus_name
  tokensdb_arn = module.databases.tokensDB_arn
  depends_on = [module.EventBridge_Datalake, module.databases]
}

module  "metrics"{
  source = "./modules/metrics"
  environment = var.environment
  eventBus_arn = module.EventBridge_Datalake.eventBus_arn
  tokensdb_arn = module.databases.tokensDB_arn
  metricsdb_arn = module.databases.metricsDB_arn
  depends_on = [module.EventBridge_Datalake, module.databases]
}

module "sugester" {
  source = "./modules/sugester"
  environment = var.environment
  eventBus_arn = module.EventBridge_Datalake.eventBus_arn
  depends_on = [module.EventBridge_Datalake]
  code_files_bucket_arn = module.tokenizer.code_files_s3_arn
}

module "apiGateWay" {
  source = "./modules/apiGateWay"
  stage = "test"
  metrics_lambda = module.metrics.metrics_lambda
  sugester_lambda = module.sugester.get_sugestion_lambda
  environment = var.environment
  depends_on = [module.metrics, module.sugester]
}