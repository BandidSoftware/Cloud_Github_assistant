resource "aws_s3_bucket" "code_files" {
  bucket = "code-files"
}

module "role_creation"{
  source = "role_creation"
  environment = var.environment
  code_files_bucket = aws_s3_bucket.code_files.arn
  eventBus_arn = var.eventBus_arn
}

resource "aws_lambda_function" "tokenizer" {
  function_name = "tokenizer"
  role          = module.role_creation.role_arn
  handler = "" //todo despliegue
}

resource "aws_lambda_permission" "allow_api_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.tokenizer.function_name
  principal     = "apigateway.amazonaws.com"
}

resource "aws_lambda_permission" "s3_event_permision" {
  statement_id = "AllowExecutionFromS3"
  action = "lambda::InvokeFunction"
  function_name = aws_lambda_function.tokenizer.function_name
  principal     = "s3.amazonaws.com"
  source_arn = aws_s3_bucket.code_files.arn
}

resource "aws_s3_bucket_notification" "upload_notification" {
  bucket = aws_s3_bucket.code_files.bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.tokenizer.arn
    events = ["s3::ObjectCreated:*"]
  }
}