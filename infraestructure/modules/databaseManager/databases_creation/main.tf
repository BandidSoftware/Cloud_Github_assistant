resource "aws_dynamodb_table" "tokens" {
  hash_key = "user-id"
  range_key = "file-name"
  name     = "git-radar-tokens"

  attribute {
    name = "user-id"
    type = "S"
  }

  attribute {
    name = "file-name" //Ruta del archivo desde la raiz del proyecto
    type = "S"
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
