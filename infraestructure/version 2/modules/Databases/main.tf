
resource "aws_dynamodb_table" "tokens" {
  hash_key = "user-id"
  range_key = "token-id"
  name     = "git-radar-tokens"

  attribute {
    name = "user-id"
    type = "S"
  }

  attribute {
    name = "token-id"
    type = "N"
  }

  attribute {
    name = "type"
    type = "S"
  }

  global_secondary_index {
    hash_key        = "type"
    range_key = "token-id"
    name            = "Type index"
    projection_type = "INCLUDE"
    non_key_attributes = ["user-id"]
  }

  tags = {
    enviroment = var.environment
  }
}

resource "aws_dynamodb_table" "users" {
  hash_key = "user-id"
  name     = "git-radar-users"

  attribute {
    name = "user-id"
    type = "S"
  }


  tags = {
    enviroment = var.environment
  }

}

resource "aws_dynamodb_table" "users-models" {
  hash_key = "user-id"
  name     = "git-radar-users-models"

  attribute {
    name = "user-id"
    type = "S"
  }

  tags = {
    enviroment = var.environment
  }
}