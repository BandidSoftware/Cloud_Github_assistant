output "metrics_lambda" {
  value = aws_lambda_function.metrics.invoke_arn
}