resource "aws_iam_role" "db_manager_rol" {
  name = "db-manager-role"  # Nombre del rol

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["dynamodb:Scan", "dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:UpdateItem", "dynamodb:DeleteItem"],
        Effect   = "Allow",
        Resource = [var.tokensdb_arn, var.usersdb_arn]
      }
    ]
  })
}

output "role_arn" {
  value = aws_iam_role.db_manager_rol.arn
}
