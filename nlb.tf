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

resource "aws_lb_target_group_attachment" "k8s-lb-attachment" {
  count = length(var.ip_list)
  target_group_arn = module.nlb.target_group_arns[0]
  target_id        = "${element(var.ip_list, count.index)}"
}
