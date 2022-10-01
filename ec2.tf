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
