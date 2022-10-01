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
ec2_worker_node_count = 3
ec2_ami = "ami-0149b2da6ceec4bb0"
ec2_instance_type = "t3.micro"

ebs_device_name = "/dev/sda1"
ebs_volume_size = "50"

key_pair_name = "kubernetes"
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+0JaDtYh1QQdjS2USVKN9jJLFdiAE6pnoBKlrJFtk+W3oFLYfLPK08sSv7iqpGn0+VnspIgZ6LUOeNPukXRNMQ3a7VyHtPE8UHMlXsgdN3m6gDR5D5yXWLHpJI4ldasF7zqX3Ihjih86VPgN/go2B3ljVNrpilHqR+x44dv3/g203mdRn7ktg6rqrY4Uq/lvYN5NsntnL0I5sLN9mEpkYAhBbXVUFEo2V1VycbFYb4wXzESLz2plUCGbkehGjld7rW+3otef9taoYe5s19PZ2vZk1TileNnwhOGnDHKzY8I14KJBEr+o9BMgih8IQtou4KOWwDdfzMWFdU/Zl6X9G/cSpfb1IeL4JcFZHAZ+7FACngvfdIe0EUzEGkiMI/0JBop9tMe515LvJR7VumcrKru6kACpb7eUC8xeE3lZff5B6/RfuKgcNNzbm4KlK82tF75XewSa4DHjfa9g68TfikrNL0PYc5/8Agbbkp2pO2K/4FZxs7H20pIIo0wklxFk= ryanmartis@pop-os"


ssh_port = 22
kube_port = 6443
https_port = 443
