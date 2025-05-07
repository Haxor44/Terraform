# locals.tf - Local values
locals {
  name_prefix = "${var.environment}-ec2-deployment"
  
  common_tags = {
    Environment = var.environment
    Terraform   = "true"
    Project     = "ec2-vpc-deployment"
  }
}
