terraform {
    backend "s3" {
        bucket  = "timeoff-management-terraform"
        key     = "aws-ecs/tfstate"
        region  = "us-east-1"
    }
}

data "terraform_remote_state" "vpc_state" {
    backend   = "s3"
    workspace = terraform.workspace
    config = {
        bucket  = "timeoff-management-terraform"
        region  = "us-east-1"
        key     = "aws-vpc/tfstate"
    }
}

data "terraform_remote_state" "ecr_state" {
    backend   = "s3"
    workspace = terraform.workspace
    config = {
        bucket  = "timeoff-management-terraform"
        region  = "us-east-1"
        key     = "aws-ecr/tfstate"
    }
}

data "terraform_remote_state" "alb_state" {
    backend   = "s3"
    workspace = terraform.workspace
    config = {
        bucket  = "timeoff-management-terraform"
        region  = "us-east-1"
        key     = "aws-alb/tfstate"
    }
}