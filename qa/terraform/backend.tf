terraform {
  backend "s3" {
    bucket         = "my-org-terraform-state"
    key            = "qa/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "qa-terraform-locks"      # optional, for state locking
    encrypt        = true
  }
}