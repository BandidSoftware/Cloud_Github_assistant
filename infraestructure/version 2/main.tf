module "buckets" {
  source = "modules/buckets"
  environment = "dev"
}

module "SQS" {
  source = "modules/SQS"
}