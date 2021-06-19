variable "aws_region" {
    type    = string
    default = "us-east-1"
}

variable "environment" {
    type        = string
    default     = "dev"
}

variable "project_name" {
    type    = string
    default = "my-project"
}

variable "project_vpc_cidr" {
    type    = string
    default = "10.10.0.0/16"
}

variable "single_nat_gateway" {
    type = bool
    default = true
}

variable "cidr_subnet_bits" {
    type = number
    default = 4
}

variable "profile" {
    type = string
    default = ""
}