resource "aws_iam_role" "SQS_rol" {
  name = "SQS-rol"
  assume_role_policy = "file://"
}