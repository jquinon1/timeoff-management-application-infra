terraform {
    backend "s3" {
        bucket = "timeoff-management-terraform"
        key = "aws-alb/tfstate"
        region = "us-east-1"
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