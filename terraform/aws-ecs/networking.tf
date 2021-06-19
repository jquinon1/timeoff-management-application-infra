resource "aws_security_group" "ecs_svc_sg" {
    name   = "${var.environment}-${var.project_name}-ecs-sg"
    vpc_id = local.vpc
    
    ingress {
        protocol         = "tcp"
        from_port        = var.container_port
        to_port          = var.container_port
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    
    egress {
        protocol         = "-1"
        from_port        = 0
        to_port          = 0
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}