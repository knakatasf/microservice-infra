provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "qa" {
  key_name   = "qa-ec2-key"
  public_key = var.public_key
}

resource "aws_instance" "qa-ec2" {
  ami                    = var.ami_id # AMI is baked with the public key
  instance_type          = "t2.large"
  subnet_id              = module.vpc.public_subnets[0] # Bastion is in the public subnet
  vpc_security_group_ids = [aws_security_group.qa_ec2.id] # Security group for the bastion
  key_name               = aws_key_pair.qa.key_name

  associate_public_ip_address = true

  tags = {
    Name = "QA-EC2"
  }
}

resource "aws_eip" "qa_ec2_eip" {
  instance = aws_instance.qa-ec2.id
}
