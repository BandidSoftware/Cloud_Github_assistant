resource "aws_sqs_queue" "queue_buckets" {
  name                      = "SQS-CRUD-buckets"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  visibility_timeout_seconds = 30
  # Otras configuraciones según tus necesidades
}

resource "aws_sqs_queue" "queue_databases" {
  name                      = "SQS-CRUD-DBS"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  visibility_timeout_seconds = 30
  # Otras configuraciones según tus necesidades
}

resource "aws_sqs_queue" "queue_sugerence_petition" {
  name                      = "SQS-sugerence-petition"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  visibility_timeout_seconds = 30
  # Otras configuraciones según tus necesidades
}

resource "aws_sqs_queue" "queue_new_tokens_produced" {
  name                      = "SQS-new-tokens-produced"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  visibility_timeout_seconds = 30
  # Otras configuraciones según tus necesidades
}

resource "aws_sqs_queue" "queue_new_code_produced" {
  name                      = "SQS-new-code-produced"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  visibility_timeout_seconds = 30
  # Otras configuraciones según tus necesidades
}
