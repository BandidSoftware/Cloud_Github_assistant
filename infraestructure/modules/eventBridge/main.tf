resource "aws_s3_bucket" "datalake" {
  bucket = "git-radar-datalake"
  tags = {
    environment = var.environment
  }
}

resource "aws_cloudwatch_event_bus" "event_bus" {
  name = "git-radar-event-bus"
}

resource "aws_cloudwatch_event_rule" "datalake_rule" {
  name = "datalake-rule"
  event_bus_name = aws_cloudwatch_event_bus.event_bus.name

  event_pattern = jsonencode({
  "source": [
    "*"
  ],
  "detail-type": [
    "*"
  ]
}
)

}
resource "aws_cloudwatch_event_target" "datalake_target" {
  arn  = aws_s3_bucket.datalake.arn
  rule = aws_cloudwatch_event_rule.datalake_rule.name
  target_id = "datalake-target"
  event_bus_name = aws_cloudwatch_event_bus.event_bus.name
}