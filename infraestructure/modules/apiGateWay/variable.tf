
variable "stage" {
  default = ""
}

variable "tokenizer_lambda" {
  name = "tokenizer-lambda"
}

variable "metrics_lambda" {
  name = "metrics-lambda"
}

variable "sugester_lambda" {
  name = "sugester-lambda"
}

variable "userOperations_lambda" {}