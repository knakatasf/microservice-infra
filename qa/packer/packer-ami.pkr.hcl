packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0"
    }
  }
}

source "amazon-ebs" "amazon_linux" {
  ami_name      = "amazon-linux-docker"
  instance_type = "t2.large"
  region        = "us-east-1"

  tags = {
    Application = "amazon-linux-docker"
  }

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"
}

build {
  sources = ["source.amazon-ebs.amazon_linux"]

  provisioner "file" {
    source      = "../qa-key.pub"
    destination = "/home/ec2-user/qa-key.pub"
  }

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install -y docker",
      "sudo systemctl enable --now docker",
      "sudo usermod -aG docker ec2-user",

      "sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",

      "mkdir -p /home/ec2-user/.ssh",
      "cat /home/ec2-user/qa-key.pub >> /home/ec2-user/.ssh/authorized_keys",
      "chown -R ec2-user:ec2-user /home/ec2-user/.ssh",
      "chmod 700 /home/ec2-user/.ssh",
      "chmod 600 /home/ec2-user/.ssh/authorized_keys",

      "echo 'Setup complete' > /home/ec2-user/packer-log.txt"
    ]
  }
}