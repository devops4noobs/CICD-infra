resource "aws_s3_bucket" "s3" {
  bucket = "s3-lock-devops4noobs"
  force_destroy = true
  tags = {
    Name        = "bucket"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "Lock-Files"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
  
  attribute {
    name = "LockID"
    type = "S"
  }
}