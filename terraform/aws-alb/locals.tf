locals {
  	public_subnets = data.terraform_remote_state.vpc_state.outputs.vpc_public_subnet_ids
  	vpc = data.terraform_remote_state.vpc_state.outputs.vpc_id
  	vpc_cidr = data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block
}