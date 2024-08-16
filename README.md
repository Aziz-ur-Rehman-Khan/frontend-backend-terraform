# Terraform Infrastructure Management

This project manages infrastructure using Terraform. It provides modular scripts for provisioning resources on AWS.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine
- AWS account credentials configured

## Getting Started

1. **Clone Repository:**

    ```bash
    git clone https://github.com/Aziz-ur-Rehman-Khan/xquic-terraform.git
    cd xquic-terraform
    ```

2. **Initialize Terraform:**

    Before you can start working with Terraform in a project, you need to initialize it using the `terraform init` command. This command performs several essential tasks to set up your environment:

    - **Provider Installation**: 
        Terraform uses providers to interact with cloud platforms and other APIs. `terraform init` downloads and installs the necessary provider plugins specified in your configuration files.

    - **Module Installation (if applicable)**:
        If your project uses modules, `terraform init` downloads and installs the module sources specified in your configuration files. This ensures that Terraform can access and use the module code during resource provisioning.

    - **Backend Initialization (if applicable)**:
        If you've configured a remote backend for storing Terraform state, such as Amazon S3 or HashiCorp Consul, `terraform init` initializes the backend configuration. This includes setting up the connection details and configuring state locking if necessary.

    To initialize the Terraform project, navigate to the root directory of your project in the terminal and run:

    ```bash
    terraform init
    ```

    ### Terraform Configuration

    ```hcl
    terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0"
        }
      }
    }

    variable "aws_profiles" {
      description = "A map of AWS profiles corresponding to different environments"
      type        = map(string)
      default = {
        default    = "staging"
        staging    = "staging"
        production = "production"
        dev        = "dev"
      }
    }

    provider "aws" {
      region                   = "us-east-1"
      shared_config_files      = ["$HOME/.aws/conf"]
      shared_credentials_files = ["$HOME/.aws/credentials"]
      profile                  = lookup(var.aws_profiles, terraform.workspace, var.aws_profiles["default"])
    }
    ```

    ### Notes:
    - Ensure that you have the AWS CLI installed and configured with the appropriate profiles with credentials.
    - Ensure that you have configure workspaces and profiles based on enviorments "dev,staging and production".
    - You may need to adjust the region, shared_config_files, shared_credentials_files, and profile settings according to your AWS setup.
    - Remember to run `terraform init` after creating or modifying your Terraform configuration to initialize the project and download the necessary provider plugins.

3. **Customize Variables:**

    If necessary, modify the variables in `<environment>.tfvars`to match your specific requirements. Create different `.tfvars` files for different environments. Variables can be passed to the modules from the root module files (`.tfvars` files, `variables.tf` files, or `locals.tf` files) or used default values described in the module's `variable.tf` file.

## Usage

### Plan

To preview the changes that Terraform will make:

```bash
terraform plan -var-file="./<environment>.tfvars"
```

### Apply

To apply the changes and provision resources:

```bash
terraform apply -var-file="./<environment>.tfvars"
```

### Destroy

To destroy all resources created by Terraform:

```bash
terraform destroy -var-file="./<environment>.tfvars"
```

## Additional Commands

### Formatting Terraform Files:

```bash
terraform fmt -recursive
```

### Viewing Terraform State:

```bash
terraform state list
```

### Refreshing State:

```bash
terraform refresh -var-file="./<environment>.tfvars"
```

### Working with Specific Targets:

You can use the `-target` flag to apply changes to specific modules or resources. For example:

```bash
terraform apply -target=module.ecs.aws_ecs_service.sidekiq_service -var-file="./<environment>.tfvars"
```

### Using Variable Files

The `-var-file` flag allows you to specify a file containing variable values to be used during Terraform operations.

```bash 
terraform plan -var-file=./<environment>.tfvars
```

You can also use the `-var` flag to directly specify variables in the command line.

```bash 
terraform apply -var="region=us-west-2" -var="instance_type=t2.micro"
```

## Directory Structure

```
.
├── backend.tf
├── environmentfiles
│   ├── backend-<environment>.env
│   └── frontend-<environment>.env
├── locals.tf
├── main_module.md
├── main.tf
├── modules
│   ├── waf
│   ├── ecs
│   ├── ecr
│   ├── secret_manager
│   └── vpc
├── outputs.tf
├── provider.tf
├── README.md
├── <environment>.tfvars
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraform.tfstate.d
└── variables.tf
```

### Summary

```
This Terraform repository offers a cohesive framework for managing scalable infrastructure across AWS. It includes modular organization with detailed module documentation (*.md files) for clarity. Leveraging dynamic providers, AWS profiles mapped to Terraform workspaces, and environment-specific .env files ensures flexible and secure deployment. State management via S3 and predefined notification templates further enhance reliability and operational visibility
```