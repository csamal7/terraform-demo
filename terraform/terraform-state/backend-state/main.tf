provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "enterprise_backend_state" {
  bucket = "app-backend-state-tfproj123"

//Always keep true to avoid deletion
  lifecycle {
    prevent_destroy = false
  }
}
//Ecryption using AES256
resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.enterprise_backend_state.id
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
    }
  }
}
 
resource "aws_s3_bucket_versioning" "versioning_eg" {
  bucket = aws_s3_bucket.enterprise_backend_state.id  
  versioning_configuration {
    status = "Enabled"
  }
}

//DynamoDB for Locking
resource "aws_dynamodb_table" "enterprise_backend_lock" {
  name = "app-backend-locks"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}
