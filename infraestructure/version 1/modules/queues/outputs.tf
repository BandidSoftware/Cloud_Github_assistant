output "queue_urls" {
  value = [
    aws_sqs_queue.queue_artifacts.url,
    aws_sqs_queue.queue_code_files.url,
    aws_sqs_queue.queue_datalake.url,
    aws_sqs_queue.queue_tokens.url,
    aws_sqs_queue.queue_clients.url,
    aws_sqs_queue.queue_sugerence_petition.url,
    aws_sqs_queue.queue_new_tokens_produced.url,
    aws_sqs_queue.queue_new_code_produced.url,
  ]
}

output "queue_arns" {
  value = [
    aws_sqs_queue.queue_artifacts.arn,
    aws_sqs_queue.queue_code_files.arn,
    aws_sqs_queue.queue_datalake.arn,
    aws_sqs_queue.queue_tokens.arn,
    aws_sqs_queue.queue_clients.arn,
    aws_sqs_queue.queue_sugerence_petition.arn,
    aws_sqs_queue.queue_new_tokens_produced.arn,
    aws_sqs_queue.queue_new_code_produced.arn,
  ]
}
