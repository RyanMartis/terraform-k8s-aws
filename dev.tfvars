aws_profile_name = "default"
aws_region = "us-east-1"
aws_azs = ["us-east-1a"]
vpc_name = "kubernetes-the-hard-way"
vpc_cidr_block = "10.0.0.0/16"
vpc_all_cidr_block = "0.0.0.0/0"

tag_name = "kubernetes-the-hard-way"
tag_environment = "dev"
tag_terraform = "true"

public_subnet_cidr_block = ["10.0.1.0/24"]
sg_name = "kubernetes-the-hard-way"

ssh_port = 22
kube_port = 6443
https_port = 443
