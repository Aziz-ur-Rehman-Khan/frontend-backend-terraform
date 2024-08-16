terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = "~> 0.61.0"
    }
  }

  # backend "s3" {
  #   bucket                   = "terraform-state"
  #   key                      = "terraform.tfstate"
  #   dynamodb_table           = "terraform-state"
  #   region                   = "us-east-1"
  #   shared_config_files      = ["$HOME/.aws/conf"]
  #   shared_credentials_files = ["$HOME/.aws/credentials"]
  #   profile                  = "dev"
  #   encrypt                  = true
  # }
}

provider "aws" {
  region                   = "us-east-1"
  shared_config_files      = ["$HOME/.aws/conf"]
  shared_credentials_files = ["$HOME/.aws/credentials"]
  profile                  = "dev"
}
