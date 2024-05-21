variable "users" {
  #default = ["dev", "test", "stage", "prod"]
  default = {
    dev : { location : "Pune" },
    qa : { location : "Hyd" },
    prod : { location : "Blore" },
    stage : { location : "Noida" }
  }
}


#variable "iam_user_name_prefix"{
#  type = string
#  default = "my_iam_tfuser"
#}

provider "aws" {
  region = "us-east-1"
  #version = "~> 2.46"
}
#resource "aws_s3_bucket" "my_s3_bucket" {
#  bucket = "my-s3-bucket-udemy-in28min-002"
#  versioning {
#    enabled = true
#  }
#}

resource "aws_iam_user" "my_iam_users" {
  #count = length(var.names)
  #name = "${var.iam_user_name_prefix}_${count.index}"
  #name  = var.names[count.index]
  #for_each = toset(var.names)
  #name = each.value
  for_each = var.users
  name     = each.key
  tags = {
    #place: each.value
    location : each.value.location
  }

}

