provider "aws" {
  region                  = var.region
  access_key              = var.access_key
  secret_key              = var.secret_key
  skip_credentials_check = true
  skip_metadata_api_check = true
  endpoint                = var.access_point
}
