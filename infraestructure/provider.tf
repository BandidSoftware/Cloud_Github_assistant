provider "aws" {
  region                  = var.region
  access_key              = var.access_key
  secret_key              = var.secret_key
  skip_metadata_api_check = true
  access_point = var.access_point
}
