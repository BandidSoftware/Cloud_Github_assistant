resource "aws_dynamodb_table" "tokens-datamart" {
  name           = var.datamart_table_name
  billing_mode   = "PAY_PER_REQUEST" #Cambiar según necesidades del cliente
  hash_key       = "token_id"

  attribute {
    name = "token_id"
    type = "S"
  }
  tags = {
    Name = var.datamart_table_name
  }

}

resource "aws_dynamodb_table" "clients" {
  name           = var.clients_table_name
  billing_mode   = "PAY_PER_REQUEST" #Cambiar según necesidades del cliente
  hash_key       = "client_id"
  
  attribute {
    name = "client_id"
    type = "S"
  }

  tags = {
    Name = var.clients_table_name
  }
}

#Posible modificaciones