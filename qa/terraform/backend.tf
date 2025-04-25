terraform {
  backend "s3" {
    bucket         = "your-tfstate-bucket"
    key            = "qa/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "your-lock-table"
  }
}