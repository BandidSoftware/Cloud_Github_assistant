resource "aws_iam_role" "tokenizer_rol" {
  name = "tokenizer-role"  # Nombre del rol

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action   : ["s3:GetObject"],
        Effect   : "Allow",
        Resource : [var.code_files_bucket]

      }
    ]
  })
}

output "role_arn" {
  value = aws_iam_role.tokenizer_rol.arn
}
