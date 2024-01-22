resource "aws_iam_policy" "lambda_sqs" {
  name = "git-radar-lambda-sqs-policy"

  policy = jsondecode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage"
        ],
        "Resource": "arn:aws:sqs:REGION:ACCOUNT_ID:TU_COLA_SQS"
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_dynamo" {
  name = "git-radar-lambda-dynamo-policy"

  policy = jsondecode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "dynamodb:Scan",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ],
        "Resource": [//todo añadir todo el tema de las variables privadas
          "arn:aws:dynamodb::ACCOUNT_ID:table/TU_TABLA_DYNAMODB"
        ]
      }
    ]
  }
  )
}

resource "aws_iam_policy" "lambda_dynamo" {
  name = "git-radar-lambda-dynamo-policy"

  policy = jsondecode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "dynamodb:Scan",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ],
        "Resource": [//todo añadir todo el tema de las variables privadas
          "arn:aws:dynamodb::ACCOUNT_ID:table/TU_TABLA_DYNAMODB"
        ]
      }
    ]
  }
  )
}

resource "aws_iam_policy" "lambda_s3" {
  name = "git-radar-lambda-s3-policy"

  policy = jsondecode({
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
          "arn:aws:s3:::code-files/*",
          "arn:aws:s3:::code-files",
          "arn:aws:sqs:REGION:ACCOUNT_ID:queue_databases"
        ]
      }
    ]
  }
  )
}