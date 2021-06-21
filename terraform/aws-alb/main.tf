resource "aws_security_group" "alb_sg" {
  	name        = "${var.environment}-${var.project_name}-alb-sg"
  	description = "Security Group for ALB"
  	vpc_id      = local.vpc

  	ingress {
		description = "Access HTTP"
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
  	}

  	ingress {
		description = "Access HTTPS"
		from_port   = 443
		to_port     = 443
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
  	}

  	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
  	}

  	tags = {
		Name = "${var.environment}-${var.project_name}-alb-sg"
  	}
}

module "alb" {
	source             = "terraform-aws-modules/alb/aws"
	version            = "5.0"
	name               = "${var.environment}-${var.project_name}-alb"
	load_balancer_type = "application"
	vpc_id             = local.vpc
	subnets            = local.public_subnets
	security_groups    = [aws_security_group.alb_sg.id] 
	target_groups = [
		{
			name_prefix      = "ing-"
			backend_protocol = "HTTP"
			backend_port     = var.target_group_backend_port
			target_type      = "ip"
			health_check = {
      		  enabled             = true
      		  interval            = 30
      		  path                = "/"
      		  port                = "traffic-port"
      		  healthy_threshold   = 3
      		  unhealthy_threshold = 3
      		  timeout             = 6
      		  protocol            = "HTTP"
      		  matcher             = "200-399"
      		}
		}
	]   
	http_tcp_listeners = [
		{
			port               = 80
			protocol           = "HTTP"
			target_group_index = 0
		}
	]   
	https_listeners = [
		{
			port               = 443
			certificate_arn    = var.alb_certificate_arn
			ssl_policy         = "ELBSecurityPolicy-TLS-1-2-2017-01"
			target_group_index = 0
		}
	]   
	tags = {
		Name = "${var.environment}-${var.project_name}-alb"
	}
}

output "alb_arn" {
	value = module.alb.this_lb_id
}

output "alb_dns_name" {
	value = module.alb.this_lb_dns_name
}

output "alb_target_gruops_arns" {
	value = module.alb.target_group_arns
}