resource "aws_s3_bucket" "git-radar-code-files" {
  bucket = "git-radar-code-files"

  tags = {
    Name = "git-radar-code-files"
    Enviroment = var.environment
  }
}

resource "aws_s3_bucket" "git-radar-datalake" {
  bucket = "git-radar-datalake"

  tags = {
    Name = "git-radar-datalake"
    Enviroment = var.environment
  }
}

resource "aws_s3_bucket" "git-radar-source-code" {
  bucket = "git-radar-source-code"

  tags = {
    Name = "git-radar-source-code"
    Enviroment = var.environment
  }
}