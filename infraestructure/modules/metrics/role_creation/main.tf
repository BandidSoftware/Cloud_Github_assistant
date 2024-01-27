resource "aws_iam_role" "metrics_role" {
  name = "metrics-role"  # Nombre del rol

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action   : ["events:PutEvents"],
        Effect   : "Allow",
        Resource : [var.eventBus_arn]

      }
    ]
  })
}

output "role_arn" {
  value = aws_iam_role.metrics_role.arn
}
