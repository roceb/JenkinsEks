locals {
  bucket_for_state = "some-bucket-to-store-state"

  default_vpc_name    = "defaultVPC"
  default_subnet_name = "defaultSubnet"

  ec2_sg_name    = "ec2SecurityGroup"
  ec2_sg_desc    = "Allow access on Ports 22 and 8080"
  ec2_sg_tag_val = "Jenkins Server Security Group"

  ec2_sg_http_proxy_desc     = "HTTP Proxy"
  ec2_sg_http_proxy_port     = 8080
  ec2_sg_http_proxy_protocol = "tcp"
  ec2_sg_http_proxy_cidr     = "0.0.0.0/0"

  ec2_sg_ssh_proxy_desc     = "SSH Proxy"
  ec2_sg_ssh_proxy_port     = 22
  ec2_sg_ssh_proxy_protocol = "tcp"
  ec2_sg_ssh_proxy_cidr     = "0.0.0.0/0"

  ec2_sg_egress_port      = 0
  ec2_sg_egrress_protocol = -1
  ec2_sg_egress_cidr      = "0.0.0.0/0"

  ec2_keypair_name     = "tf-key-pair"
  ec2_instanct_tag_val = "JenkinsServer"

  iam_policy_name               = "jenkins_iam_policy"
  iam_role_name                 = "jenkins_iam_role"
  iam_policy_attachment_name    = "policy_attachment"
  jenkins_instance_profile_name = "jenkins_instance_profile"

  ssh_connection_user             = "ec2-user"
  ssh_connection_file_source      = "./scripts/script.sh"
  ssh_connection_file_destination = "/tmp/script.sh"
}
