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
nlb_name = "kubernetes-the-hard-way-nlb"
nlb_target_group_name = "k8s"
ip_list = ["10.0.1.10", "10.0.1.11", "10.0.1.12"]
ec2_control_node_count = 3
ec2_ami = "ami-0149b2da6ceec4bb0"
ec2_instance_type = "t3.micro"

ssh_port = 22
kube_port = 6443
https_port = 443
