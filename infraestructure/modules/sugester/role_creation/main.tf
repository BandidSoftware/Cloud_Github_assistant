variable "environment" {
  description = "Wich enviroment is being build"
}

variable "eventBus_arn" {}
variable "models_bucket_arn" {}

resource "aws_iam_role" "sugester_rol" {
  name = "sugester-role"  # Nombre del rol

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action   : ["events:PutEvents"],
        Effect   : "Allow",
        Resource : [var.eventBus_arn]

      },
      {
        Action   : ["s3:GetObject", "s3:PutObject"],
        Effect   : "Allow",
        Resource : [var.models_bucket_arn]
      },
    ]
  })
}

output "role_arn" {
  value = aws_iam_role.sugester_rol.arn
}

output "role_id" {
  value = aws_iam_role.sugester_rol.id
}