module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "2.70.0"
    name   = "${var.environment}-${var.project_name}-vpc"
    cidr   = var.project_vpc_cidr
    azs    = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c", "${var.aws_region}d"]
    private_subnets = [
        cidrsubnet(var.project_vpc_cidr, var.cidr_subnet_bits, 0),
        cidrsubnet(var.project_vpc_cidr, var.cidr_subnet_bits, 1)
    ]

    private_subnet_tags = {
        Name =  "${var.environment}-private-${var.project_name}-subnet"
    }

    public_subnets = [
        cidrsubnet(var.project_vpc_cidr, var.cidr_subnet_bits, 2),
        cidrsubnet(var.project_vpc_cidr, var.cidr_subnet_bits, 3)
    ]

    public_subnet_tags = {
        Name = "${var.environment}-public-${var.project_name}-subnet"
    }

    enable_nat_gateway     = true
    single_nat_gateway     = var.single_nat_gateway
    one_nat_gateway_per_az = false

    enable_vpn_gateway   = false
    enable_dns_hostnames = true
    enable_dns_support   = true
    enable_sqs_endpoint  = false

    tags = {
        Name = "${var.environment}-${var.project_name}-vpc"
    }
}

output "vpc_id" {
    value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
    value = module.vpc.vpc_cidr_block
}

output "vpc_private_subnet_ids" {
    value = module.vpc.private_subnets
}

output "vpc_public_subnet_ids" {
    value = module.vpc.public_subnets
}

output "vpc_environment" {
    value = var.environment
}

output "vpc_aws_region" {
    value = var.aws_region
}

output "project_name" {
    value = var.project_name
}