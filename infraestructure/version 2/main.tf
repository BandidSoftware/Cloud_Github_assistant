module "buckets" {
  source = "modules/buckets"
  environment = "dev"
}

module "SQS" {
  source = "modules/SQS"
  environment = "dev"
}

module "Databases" {
  source = "modules/Databases"
  environment = "dev"
}

module "" {
  source = ""
}