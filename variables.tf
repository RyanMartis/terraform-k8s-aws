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
  type = string
}
variable "kube_port" {
  type = string
}
variable "https_port" {
  type = string
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


