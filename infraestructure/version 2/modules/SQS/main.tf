resource "aws_sqs_queue" "deadletter-queque" {
  name = "git-radar-deadletter-queque"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
    maxReceiveCount     = 4
  })
}

resource "aws_sqs_queue" "terraform_queue_deadletter" {
  name = "terraform-example-deadletter-queue"
}

resource "aws_sqs_queue_redrive_allow_policy" "terraform_queue_redrive_allow_policy" {
  queue_url = aws_sqs_queue.terraform_queue_deadletter.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.database-operations.arn, ]
  })
}

resource "aws_sqs_queue" "database-operations" {
  name = "git-radar-database-operations"
  fifo_queue = "true"
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
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
    deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
    maxReceiveCount     = 4
  })

  tags = {
    Enviroment = var.environment
  }
}

