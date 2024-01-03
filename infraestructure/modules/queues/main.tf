resource "aws_sqs_queue" "queue_artifacts" {
  name                      = "SQS-CRUD-artifacts"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  visibility_timeout_seconds = 30
  # Otras configuraciones según tus necesidades
}

resource "aws_sqs_queue" "queue_code_files" {
  name                      = "SQS-CRUD-code-files"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  visibility_timeout_seconds = 30
  # Otras configuraciones según tus necesidades
}

resource "aws_sqs_queue" "queue_datalake" {
  name                      = "SQS-CRUD-datalake"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  visibility_timeout_seconds = 30
  # Otras configuraciones según tus necesidades
}

resource "aws_sqs_queue" "queue_tokens" {
  name                      = "SQS-CRUD-tokens"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  visibility_timeout_seconds = 30
  # Otras configuraciones según tus necesidades
}

resource "aws_sqs_queue" "queue_clients" {
  name                      = "SQS-CRUD-clients"
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
