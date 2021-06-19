variable "aws_region" {
    type = string
    default = "us-east-1"
}

variable "environment" {
    type = string
    default = "dev"
}

variable "project_name" {
    type = string
    default = "my-project"
}

variable "profile" {
    type = string
    default = ""
}

variable "container_port" {
    type = number
    default = 8080
}

variable "application_name" {
    type = string
    default = "app"
}