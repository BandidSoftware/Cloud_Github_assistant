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

module "policies" {
  source = "modules/policies"
  environment = "dev"
}

module "Rols" {
  source = "modules/rols"
  environment = "dev"
}