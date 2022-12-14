variable "aws_profile_name" {
  type = string
}
variable "aws_region" {
  type = string
}
variable "aws_azs" {
  type = list
}
variable "vpc_name" {
  type = string
}
variable "vpc_cidr_block" {
  type = string
}
variable "vpc_all_cidr_block" {
  type = string
}
variable "tag_name" {
  type = string
}
variable "tag_environment" {
  type = string
}
variable "tag_terraform" {
  type = string
}
variable "public_subnet_cidr_block" {
  type = list
}
variable "sg_name" {
  type = string
}
variable "ssh_port" {
  type = number
}
variable "kube_port" {
  type = number
}
variable "https_port" {
  type = number
}
variable "nlb_name" {
  type = string
}
variable "nlb_target_group_name" {
  type = string
}
variable "ip_list" {
  type = list
}
variable "ec2_control_node_count" {
  type = number
}
variable "ec2_worker_node_count" {
  type = number
}
variable "ec2_ami" {
  type = string
}
variable "ec2_instance_type" {
  type = string 
}
variable "ebs_device_name" {
  type = string 
}
variable "ebs_volume_size" {
  type = string 
}
variable "key_pair_name" {
  type = string 
}
variable "public_key" {
  type = string 
}


