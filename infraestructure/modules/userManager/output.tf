output "userManager_lambda" {
  value = aws_lambda_function.user_manager.arn
}

output "userManager_invoke" {
  value = aws_lambda_function.user_manager.invoke_arn
}