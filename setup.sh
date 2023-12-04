#!bin/bash

aws sqs create-queue --queue-name "sugestion_requests"
aws sqs create-queue --queue-name "sugestions"

aws events create-event-bus --name "gitRadar-bus"

aws s3 mb "s3://gitRadar-datalake"

aws s3 mb "s3://gitRadar-code-files"

aws s3 mb "s3://gitRadar-artifacts"
#Cargamos los .jar y .py al bucket

aws iam create-policy --policy-name "service-execution-policy" --policy-document "file://setup/policy.service-execution.json"
aws iam create-role --role-name "service-role" --assume-role-policy-document "file://setup/policy.role.json"
aws iam attach-role-policy --role-name "service-role" --policy-arn "arn:aws:iam::000000000000:policy/service-execution-policy"

aws lambda create-function --cli-input-json file://setup/service.token-analyser.json --code S3Bucket=gitRadar-artifacts,S3Key= #El codigo cuando lo tengamos
#Resto de lambas las que sea q haya
# lambda que meta los datos externos pa entro

aws events put-rule --name "sqs-request-rule" --event-pattern "file://setup/event-pattern.sqs-request.json"
aws events put-targets --rule "sqs-request-rule" --targets "Id"="1","Arn"="arn:aws:lambda:us-east-1:000000000000:function..."#lamda q decidamos

aws events put-rule --name "token-analyser-rule" --event-bus "gitRadar-bus" --event-pattern "file://setup/event-pattern.token.json"
aws events put-targets --rule "token-analyser-rule" --event-bus "gitRadar-bus" --targets "Id"="1","Arn"="arn:aws:lambda:us-east-1:000000000000:function:token-analyser"