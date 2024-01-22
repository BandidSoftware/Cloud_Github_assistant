resource "aws_sqs_queue" "deadletter-queque" {
  name = "git-radar-deadletter-queque"
}

resource "aws_sqs_queue_redrive_allow_policy" "terraform_queue_redrive_allow_policy" {
  queue_url = aws_sqs_queue.deadletter-queque.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.sugestion-requests.arn,
                          aws_sqs_queue.user-operations.arn,
                          aws_sqs_queue.metrics-requests.arn]
  })
}

resource "aws_sqs_queue" "sugestion-requests" {
  name = "git-radar-sugestion-requests"
  fifo_queue = "true"
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter-queque.arn
    maxReceiveCount     = 4
  })

  tags = {
    Enviroment = var.environment
  }
}

resource "aws_sqs_queue" "user-operations" {
  name = "git-radar-user-operations"
  fifo_queue = "true"
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter-queque.arn
    maxReceiveCount     = 4
  })

  tags = {
    Enviroment = var.environment
  }
}

resource "aws_sqs_queue" "metrics-requests" {
  name = "git-radar-metrics-requests"
  fifo_queue = "true"
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter-queque.arn
    maxReceiveCount     = 4
  })

  tags = {
    Enviroment = var.environment
  }
}
