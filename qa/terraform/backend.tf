terraform {
  backend "s3" {
    bucket         = "my-org-terraform-state"
    key            = "qa/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}