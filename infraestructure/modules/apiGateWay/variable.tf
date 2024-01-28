
variable "stage" {
  default = ""
}

variable "tokenizer_lambda" {
  name = "tokenizer-lambda"
}

variable "metrics_lambda" {
  name = "metrics-lambda"
}

variable "sugester-lambda" {
  name = "sugester-lambda"
} //