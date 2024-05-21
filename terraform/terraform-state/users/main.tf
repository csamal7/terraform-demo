terraform {
  backend "s3" {
    bucket = "app-backend-state-tfproj123"
    key = "backend-state-users-dev"
    region = "us-east-1"
    dynamodb_table = "app-backend-locks"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "my_iam_user" {
  name = "my_iam_usertf"
}
