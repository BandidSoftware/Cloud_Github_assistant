output "datamart_table_name" {
  value = aws_dynamodb_table.datamart.name
}

output "clients_table_name" {
  value = aws_dynamodb_table.clients.name
}