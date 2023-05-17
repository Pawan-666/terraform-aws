terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-ekbana"
    key            = "level2.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-remote-state-lock"
  }
}
