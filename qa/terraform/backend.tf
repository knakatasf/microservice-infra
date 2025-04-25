terraform {
  backend "s3" {
    bucket         = "your-tfstate-bucket"
    key            = "qa/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "your-lock-table"
  }
}