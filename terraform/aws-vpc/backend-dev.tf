terraform {
    backend "s3" {
        bucket  = "timeoff-management-terraform"
        key     = "aws-vpc/tfstate"
        region  = "us-east-1"
    }
}