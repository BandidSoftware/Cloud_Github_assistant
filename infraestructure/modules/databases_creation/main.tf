variable "enviroment" {}

resource "aws_dynamodb_table" "tokens" {
  hash_key = "user-id"
  range_key = "file-id"

  name     = "git-radar-tokens"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "user-id"
    type = "S"
  }

  attribute {
    name = "file-id" //Ruta del archivo desde la raiz del proyecto
    type = "S"
  }

  tags = {
    enviroment = var.enviroment
  }
}

resource "aws_dynamodb_table" "users" {
  hash_key = "user-id"
  name     = "git-radar-users"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "user-id"
    type = "S"
  }


  tags = {
    enviroment = var.enviroment
  }

}

output "tokensDB_arn" {value = aws_dynamodb_table.tokens.arn}

output "usersDB_arn" {value = aws_dynamodb_table.users.arn }
