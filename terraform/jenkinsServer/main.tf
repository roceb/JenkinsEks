terraform {
  # Here we can add a backend to store the state to make it easy to update with jenkins and other developers

  #   backend "s3" {
  #     bucket = local.bucket_for_state
  #     key = "tf-infra/terraform.tfstate"
  #     region = "us-east-2"
  #   }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "vpc" {
  source              = "./modules/vpc"
  default_vpc_name    = local.default_vpc_name
  default_subnet_name = local.default_subnet_name
}

module "iam" {
  source                        = "./modules/iam"
  iam_policy_name               = local.iam_policy_name
  iam_role_name                 = local.iam_role_name
  iam_policy_attachment_name    = local.iam_policy_attachment_name
  jenkins_instance_profile_name = local.jenkins_instance_profile_name
}

module "server" {
  source         = "./modules/server"
  vpc_id         = module.vpc.default_vpc_id
  ec2_sg_name    = local.ec2_sg_name
  ec2_sg_desc    = local.ec2_sg_desc
  ec2_sg_tag_val = local.ec2_sg_tag_val

  ec2_sg_http_proxy_desc     = local.ec2_sg_http_proxy_desc
  ec2_sg_http_proxy_port     = local.ec2_sg_http_proxy_port
  ec2_sg_http_proxy_protocol = local.ec2_sg_http_proxy_protocol
  ec2_sg_http_proxy_cidr     = local.ec2_sg_http_proxy_cidr

  ec2_sg_ssh_proxy_desc     = local.ec2_sg_ssh_proxy_desc
  ec2_sg_ssh_proxy_port     = local.ec2_sg_ssh_proxy_port
  ec2_sg_ssh_proxy_protocol = local.ec2_sg_ssh_proxy_protocol
  ec2_sg_ssh_proxy_cidr     = local.ec2_sg_ssh_proxy_cidr

  ec2_sg_egress_port      = local.ec2_sg_egress_port
  ec2_sg_egrress_protocol = local.ec2_sg_egrress_protocol
  ec2_sg_egress_cidr      = local.ec2_sg_egress_cidr

  default_az_id                 = module.vpc.default_az_id
  jenkins_instance_profile_name = module.iam.jenkins_instance_profile_name
  ec2_keypair_name              = local.ec2_keypair_name
  ec2_instanct_tag_val          = local.ec2_instanct_tag_val
}

module "ssh_connection" {
  source                          = "./modules/ssh"
  local_file_name                 = module.server.local_file_name
  public_ip                       = module.server.public_ip
  ssh_connection_user             = local.ssh_connection_user
  ssh_connection_file_source      = local.ssh_connection_file_source
  ssh_connection_file_destination = local.ssh_connection_file_destination
}
