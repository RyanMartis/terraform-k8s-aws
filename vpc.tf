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

module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = var.nlb_name 

  load_balancer_type = "network"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  target_groups = [
    {
      name_prefix      = var.nlb_target_group_name
      backend_protocol = "TCP"
      backend_port     = var.kube_port
      target_type      = "ip"
    }
  ]
  http_tcp_listeners = [
    {
      port = 443
      protocol = "TCP"
      action_type = "forward"
      target_group_index = 0
    }
  ]

  tags = {
    Terraform = var.tag_terraform
    Environment = var.tag_environment
    Name = var.tag_name
  }
}

output "target_group_arns" {
  value = [ for tg in module.nlb.target_group_arns : tg ]
}

output "tcp_listener_arns" {
  value = [ for listener in module.nlb.http_tcp_listener_arns : listener ]
}

output "load_balancer_dns_name" {
  value = module.nlb.lb_dns_name
}

output "security_group_id" {
  value = module.sg.security_group_id
}

resource "aws_lb_target_group_attachment" "k8s-lb-attachment" {
  count = length(var.ip_list)
  target_group_arn = module.nlb.target_group_arns[0]
  target_id        = "${element(var.ip_list, count.index)}"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = var.key_pair_name
  public_key = var.public_key
}  

module "ec2_instance_controller" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  count = var.ec2_control_node_count
  name = "controller-${count.index}"
  key_name = var.key_pair_name

  ami = var.ec2_ami
  instance_type = var.ec2_instance_type
  vpc_security_group_ids = [module.sg.security_group_id]
  subnet_id = module.vpc.public_subnets[0]
  ebs_block_device = [
    {
      device_name = var.ebs_device_name
      volume_size = var.ebs_volume_size
    }
  ]
  user_data = "name=controller-${count.index}"

  tags = {
    Terraform = var.tag_terraform
    Environment = var.tag_environment
  }
  
}

module "ec2_instance_worker" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  count = var.ec2_worker_node_count
  name = "worker-${count.index}"
  key_name = var.key_pair_name

  ami = var.ec2_ami
  instance_type = var.ec2_instance_type
  vpc_security_group_ids = [module.sg.security_group_id]
  subnet_id = module.vpc.public_subnets[0]
  ebs_block_device = [
    {
      device_name = var.ebs_device_name
      volume_size = var.ebs_volume_size
    }
  ]

  tags = {
    Terraform = var.tag_terraform
    Environment = var.tag_environment
  }
}












