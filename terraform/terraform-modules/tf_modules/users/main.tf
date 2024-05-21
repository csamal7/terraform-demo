variable "environment" {
  default = "default"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "my_iam_user" {
  name = "${var.environment}_my_iam_usertf"
}
