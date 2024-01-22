resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-execution-role"
  # Otras configuraciones según tus necesidades

  # Políticas para acceder a S3 y SQS
  inline_policy {
    name = "lambda-s3-sqs-policy"
    policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "s3:GetObject",
            "s3:PutObject",
            "sqs:SendMessage"
          ],
          "Resource": [
            "arn:aws:s3:::code-files/*",  # Cambiar según la estructura de tu cubo S3
            "arn:aws:s3:::code-files",
            "arn:aws:sqs:REGION:ACCOUNT_ID:queue_databases"
            "arn:aws:sqs:REGION:ACCOUNT_ID:SQS-new-tokens-produced"
          ]
        }
      ]
    }
    EOF
  }
}

resource "aws_lambda_function" "tokenizer" {
  function_name = "git-radar-tokenizer"
  handler       = "tokenizer.handler" # Pendiente de definir en función del idioma y la estructura del código
  runtime       = "nodejs14.x"
  role          = aws_iam_role.lambda_execution_role.arn
  source_code_hash = filebase64("path/to/your/lambda/artifacts.zip")  # Este es solo un marcador de posición

  # Configuración para obtener el código desde un bucket S3 (modificar cuando tengamos los handler)
  s3_bucket = "tu-bucket"
  s3_key    = "path/to/your/lambda/artifacts.zip"

  # Configuraciones adicionales según tus necesidades
  environment {
    variables = {
      key1 = "value1"
      key2 = "value2"
    }
  }

  # Otros recursos asociados, como permisos de ejecución, eventos, etc.
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-execution-role"
  # Otras configuraciones según tus necesidades

  # Políticas para acceder a S3 y SQS
  inline_policy {
    name = "lambda-s3-sqs-policy"
    policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "s3:GetObject",
            "s3:PutObject",
            "sqs:SendMessage"
          ],
          "Resource": [
            "arn:aws:s3:::code-files/*",  # Cambiar según la estructura de tu cubo S3
            "arn:aws:s3:::code-files",
            "arn:aws:sqs:REGION:ACCOUNT_ID:queue_databases"
          ]
        }
      ]
    }
    EOF
  }
}

resource "aws_lambda_function" "sugester" {
  function_name = "git-radar-sugester"
  handler       = "tokenizer.handler" # Pendiente de definir en funcion del idioma y la estructura del codigo
  runtime       = "nodejs14.x"
  role          = aws_iam_role.lambda_execution_role.arn
  source_code_hash = filebase64("path/to/your/lambda/artifacts.zip")  # Este es solo un marcador de posición

  # Configuración para obtener el código desde un bucket S3
  s3_bucket = "tu-bucket"
  s3_key    = "path/to/your/lambda/artifacts.zip"

  # Configuraciones adicionales según tus necesidades
  environment {
    variables = {
      key1 = "value1"
      key2 = "value2"
    }
  }

  # Otros recursos asociados, como permisos de ejecución, eventos, etc.
}

resource "aws_lambda_function" "DBManager" {
  function_name = "git-radar-DBManager"
  handler       = "tokenizer.handler" # Pendiente de definir en funcion del idioma y la estructura del codigo
  runtime       = "nodejs14.x"
  role          = aws_iam_role.lambda_execution_role.arn
  source_code_hash = filebase64("path/to/your/lambda/artifacts.zip")  # Este es solo un marcador de posición

  # Configuración para obtener el código desde un bucket S3
  s3_bucket = "tu-bucket"
  s3_key    = "path/to/your/lambda/artifacts.zip"

  # Configuraciones adicionales según tus necesidades
  environment {
    variables = {
      key1 = "value1"
      key2 = "value2"
    }
  }

  # Otros recursos asociados, como permisos de ejecución, eventos, etc.
}

resource "aws_lambda_function" "S3Manager" {
  function_name = "git-radar-S3Manager"
  handler       = "tokenizer.handler" # Pendiente de definir en funcion del idioma y la estructura del codigo
  runtime       = "nodejs14.x"
  role          = aws_iam_role.lambda_execution_role.arn
  source_code_hash = filebase64("path/to/your/lambda/artifacts.zip")  # Este es solo un marcador de posición

  # Configuración para obtener el código desde un bucket S3
  s3_bucket = "tu-bucket"
  s3_key    = "path/to/your/lambda/artifacts.zip"

  # Configuraciones adicionales según tus necesidades
  environment {
    variables = {
      key1 = "value1"
      key2 = "value2"
    }
  }

  # Otros recursos asociados, como permisos de ejecución, eventos, etc.
}


