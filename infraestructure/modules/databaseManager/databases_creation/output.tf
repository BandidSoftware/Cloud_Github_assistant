output "tokensDB_arn" {
  value = aws_dynamodb_table.tokens.arn
}

output "usersDB_arn" {
  value = aws_dynamodb_table.users.arn
}
