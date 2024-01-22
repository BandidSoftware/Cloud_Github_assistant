provider "aws" {
  region                  = "us-east-1"
  access_key              = "test"
  secret_key              = "test"
  skip_credentials_check = true
  skip_metadata_api_check = true
  endpoint                = "http://localhost:4566"
}
