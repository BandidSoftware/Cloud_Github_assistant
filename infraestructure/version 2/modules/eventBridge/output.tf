output "eventBus_arn" {
  value = aws_cloudwatch_event_bus.event_bus.arn
}

output "eventBus_name" {
  value = aws_cloudwatch_event_bus.event_bus.name
}