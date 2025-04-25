output "qa_ec2_public_ip" {
  description = "The public IP of the QA EC2"
  value       = aws_instance.qa-ec2.public_ip
}
