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

module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = var.sg_name
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
		{
			from_port = var.ssh_port
			to_port = var.ssh_port
			protocol = "tcp"
			cidr_blocks = var.vpc_all_cidr_block
		},
		{
			from_port = var.kube_port
			to_port = var.kube_port 
			protocol = "tcp"
			cidr_blocks = var.vpc_all_cidr_block
		},
		{
			from_port = var.https_port
			to_port = var.https_port
			protocol = "tcp"
			cidr_blocks = var.vpc_all_cidr_block
		},
		{
			from_port = -1
			to_port = -1
			protocol = "icmp"
			cidr_blocks = var.vpc_all_cidr_block
		}
	]

  tags = {
    Terraform = var.tag_terraform
    Environment = var.tag_environment
    Name = var.tag_name
  }

}
