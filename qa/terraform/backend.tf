terraform {
  backend "s3" {
    bucket         = "my-org-terraform-state-1"
    key            = "qa/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}