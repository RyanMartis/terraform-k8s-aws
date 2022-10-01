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

output "security_group_id" {
  value = module.sg.security_group_id
}
