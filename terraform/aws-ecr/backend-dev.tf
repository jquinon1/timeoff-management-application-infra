terraform {
    backend "s3" {
        bucket = "timeoff-management-terraform"
        key = "aws-ecr/tfstate"
        region = "us-east-1"
    }
}