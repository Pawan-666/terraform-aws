resource "aws_s3_bucket" "terraform_remote_state" {
  bucket = "terraform-remote-state-ekbana"
}

resource "aws_dynamodb_table" "terraform_remote_state" {
  name           = "terraform-remote-state-lock"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
