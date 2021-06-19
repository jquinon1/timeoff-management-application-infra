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
    default = "dev"
}

variable "repositories" {
    type = list(object({
        name = string
        scan_on_push = bool
    }))
    default = [
        {
            name = "test-ecr"
            scan_on_push = false
        }
    ]
}