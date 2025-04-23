provider "aws" {
  region = var.aws_region
}

data "aws_ami" "image" {
  most_recent = true
  owners = ["self"] # Looks for AMIs owned by your AWS account

  filter {
    name = "tag:Application"
    values = ["amazon-linux-docker"] # Matches the tag set in Packer
  }
}

resource "aws_instance" "qa-ec2" {
  ami                    = data.aws_ami.image.id # AMI is baked with the public key
  instance_type          = "t2.large"
  subnet_id              = module.vpc.public_subnets[0] # Bastion is in the public subnet
  vpc_security_group_ids = [aws_security_group.qa_ec2.id] # Security group for the bastion

  associate_public_ip_address = true

  tags = {
    Name = "QA-EC2"
  }
}

resource "aws_eip" "qa_ec2_eip" {
  instance = aws_instance.qa-ec2.id
}
