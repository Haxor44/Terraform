# outputs.tf - Output values
output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2_instance.public_ip
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "ssh_command" {
  description = "Command to SSH into the EC2 instance"
  value       = "ssh -i ~/.ssh/id_rsa ec2-user@${module.ec2_instance.public_ip}"
}
