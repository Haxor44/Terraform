# Terraform
A revamped deployment script using terraform
Here’s the refactored Terraform deployment guide in clean, well-structured Markdown format:

```markdown
# Terraform Deployment Scripts: Best Practices

---

## 1. Use Modules for Reusability

Break down infrastructure into reusable modules instead of repeating code.

```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"
  name    = "prod-vpc"
  cidr    = "10.0.0.0/16"
}
```

**Why it matters:**  
- Reduces code duplication  
- Encourages consistency across environments  
- Simplifies maintenance  

---

## 2. Keep Configurations DRY

Use variables and locals to avoid hardcoding values.

```hcl
# variables.tf
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

# terraform.tfvars
instance_type = "t3.large"
```

**Pro Tip:**  
Store environment-specific variables in separate `.tfvars` files (e.g., `dev.tfvars`, `prod.tfvars`).

---

## 3. Use Remote State with Locking

Prevent state conflicts with remote backends:

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
```

**Key Benefits:**  
- Team collaboration  
- State versioning  
- Locking prevents concurrent modifications  

---

## 4. Implement Workspaces for Environments

Manage environments without code duplication:

```bash
terraform workspace new dev
terraform workspace select dev
```

**Workspace Use Cases:**  
- `dev` → Development environment  
- `staging` → Pre-production  
- `prod` → Production  

---

## 5. Validate and Format Code

Ensure consistency and catch errors early:

```bash
terraform fmt -recursive  # Auto-format all .tf files
terraform validate       # Check for syntax errors
```

**CI/CD Integration:**  
Add these commands to your pipeline to enforce standards.

---

## 6. Secure Sensitive Data

Never hardcode secrets:

```hcl
data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "prod/db/password"
}

resource "aws_db_instance" "example" {
  password = data.aws_secretsmanager_secret_version.db_password.secret_string
}
```

**Alternatives:**  
- Environment variables  
- Vault integration  
- Terraform Cloud's sensitive variables  

---

## 7. Automate Deployments with CI/CD

Example GitHub Actions workflow:

```yaml
jobs:
  deploy:
    steps:
      - uses: hashicorp/setup-terraform@v2
      - run: terraform init && terraform apply -auto-approve
```

**Pipeline Stages:**  
1. Plan → Review changes  
2. Apply → Deploy approved changes  
3. Notify → Alert team on completion  

---

## 8. Document Dependencies Explicitly

Use `depends_on` for resource ordering:

```hcl
resource "aws_iam_role" "lambda_role" {
  # ...
}

resource "aws_lambda_function" "example" {
  depends_on = [aws_iam_role.lambda_role]
  # ...
}
```

**When to Use:**  
- When Terraform can't auto-detect dependencies  
- For non-implicit relationships  

---

## 9. Plan Before Applying

Always review changes:

```bash
terraform plan -out=tfplan  # Save plan
terraform apply tfplan     # Apply saved plan
```

**Safety Measure:**  
Require manual approval for production deployments.

---

## 10. Destroy Unused Resources

Clean up to avoid costs:

```bash
terraform destroy -target=aws_instance.old_server
```

**Alternative:**  
Use time-to-live (TTL) patterns for temporary resources.

---

## Additional Resources

- [Official Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [AWS Terraform Modules](https://registry.terraform.io/namespaces/terraform-aws-modules)

> **Pro Tip:** Regularly update Terraform and provider versions to get security fixes and new features.
```

This version:
1. Uses consistent Markdown formatting
2. Groups related concepts together
3. Provides clear examples for each practice
4. Includes explanatory callouts and pro tips
5. Maintains a professional yet approachable tone
6. Uses proper HCL syntax highlighting

Would you like me to adjust any section's depth or add specific examples?
