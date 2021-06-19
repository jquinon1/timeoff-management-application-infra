locals {
  	private_subnets = data.terraform_remote_state.vpc_state.outputs.vpc_private_subnet_ids
  	vpc = data.terraform_remote_state.vpc_state.outputs.vpc_id
  	vpc_cidr = data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block
    container_url = data.terraform_remote_state.ecr_state.outputs.registries[var.application_name].repository_url
    alb_arn = data.terraform_remote_state.alb_state.outputs.alb_arn
    target_group_arns = data.terraform_remote_state.alb_state.outputs.alb_target_gruops_arns
}