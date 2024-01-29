variable "environment" {description = "Wich enviroment is being build" }
variable "eventBus_arn" {}
variable "tokensdb_arn" {}

resource "aws_iam_role" "metrics_role" {
  name = "metrics-role"  # Nombre del rol

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action   : ["events:PutEvents", "dynamodb:Scan", "dynamodb:GetItem"],
        Effect   : "Allow",
        Resource : [var.eventBus_arn, var.tokensdb_arn]

      }
    ]
  })
}

output "role_arn" {value = aws_iam_role.metrics_role.arn }
output "role_id" {value = aws_iam_role.metrics_role.id}
