variable "aws_region" {
    type = string
    default = "us-east-1"
}

variable "profile" {
    type = string
    default = ""
}

variable "environment" {
    type = string
    default = ""
}

variable "project_name" {
    type = string
    default = "my-project"
}

variable "target_group_backend_port" {
    type = number
    default = 80
}

variable "alb_certificate_arn" {
    type = string
    default = ""  
}