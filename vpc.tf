# Terraform Provider Config
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  profile       = var.aws_profile_name
  region        = var.aws_region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr_block
  
  azs = var.aws_azs
	public_subnets = var.public_subnet_cidr_block

  enable_dns_hostnames = true
  enable_dns_support = true
	create_igw = true

  tags = {
    Terraform = var.tag_terraform
    Environment = var.tag_environment
    Name = var.tag_name
  }
}

output "vpc_id" {
	value = module.vpc.vpc_id
}

output "subnet_id" {
	value = module.vpc.public_subnets
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = var.key_pair_name
  public_key = var.public_key
}  

