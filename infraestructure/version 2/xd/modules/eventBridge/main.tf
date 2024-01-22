resource "aws_cloudwatch_event_bus" "event_bus" {
  name = "git-radar-event-bus"
}

resource "aws_cloudwatch_event_rule" "datalake_rule" {
  name = "datalake-rule"
  event_bus_name = aws_cloudwatch_event_bus.event_bus.name
}
resource "aws_cloudwatch_event_target" "datalake_target" {
  name = "datalake-target"
  arn  = var.datalake_arn
  rule = aws_cloudwatch_event_rule.datalake_rule.name
}