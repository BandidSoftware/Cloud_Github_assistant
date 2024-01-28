output "train_sugester_lambda" {
  value = aws_lambda_function.train_sugester
}

output "get_sugestion_lambda" {
  value = aws_lambda_function.get_sugestion
}