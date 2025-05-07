```markdown
# Terraform EC2 in VPC Deployment

This Terraform project deploys an EC2 instance within a VPC following infrastructure-as-code best practices. The solution includes networking components, security groups, and proper access controls.

## Features

- **Secure VPC Architecture**: Public and private subnets with NAT gateway
- **Production-Ready EC2**: Latest Amazon Linux AMI with proper security groups
- **Best Practice Implementation**: Remote state, workspace support, and modular design
- **Access Control**: SSH key-based authentication

## Prerequisites

- AWS account with credentials configured
- Terraform 1.3.0 or later
- SSH key pair (default: `~/.ssh/id_rsa.pub`)

## Quick Start

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Create a workspace (optional):
   ```bash
   terraform workspace new dev
   ```

3. Deploy the infrastructure:
   ```bash
   terraform apply
   ```

## Configuration

Customize the deployment by editing `terraform.tfvars`:

```hcl
aws_region       = "us-west-2"
environment      = "prod"
instance_type    = "t3.medium"
public_key_path  = "~/.ssh/production_key.pub"
```

## Outputs

After deployment, Terraform will display:
- EC2 public IP address
- VPC ID
- SSH connection command

## Maintenance

### Upgrading
Update module versions in `main.tf` and run:
```bash
terraform init -upgrade
```

### Destroying Resources
To remove all created resources:
```bash
terraform destroy
```

## Best Practices Implemented

1. **Modular Design**: Uses official Terraform AWS modules
2. **Environment Isolation**: Workspace support for multiple environments
3. **State Management**: Secure remote state with locking
4. **Security**: Principle of least privilege in security groups
5. **Cost Control**: Default to t3.micro instances

## Troubleshooting

**Error: Invalid Key Pair**
- Verify your public key exists at the specified path
- Ensure the key is properly formatted

**Error: Insufficient Permissions**
- Confirm your AWS credentials have proper IAM permissions
- Check for organization SCPs that might restrict access

## Contributing

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

Apache 2.0 - See [LICENSE](LICENSE) for details.

```
