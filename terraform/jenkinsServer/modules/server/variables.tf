variable "ec2_sg_name" {
  description = "ec2_sg_name"
  type        = string
}

variable "vpc_id" {
  description = "vpc_id"
  type        = string
}

variable "ec2_sg_desc" {
  description = "ec2_sg_desc"
  type        = string
}

variable "ec2_sg_tag_val" {
  description = "ec2_sg_tag_val"
  type        = string
}

variable "ec2_sg_http_proxy_desc" {
  description = "ec2_sg_http_proxy_desc"
  type        = string
}

variable "ec2_sg_http_proxy_port" {
  description = "ec2_sg_http_proxy_port"
  type        = number
}

variable "ec2_sg_http_proxy_protocol" {
  description = "ec2_sg_http_proxy_protocol"
  type        = string
}

variable "ec2_sg_http_proxy_cidr" {
  description = "ec2_sg_http_proxy_cidr"
  type        = string
}

variable "ec2_sg_ssh_proxy_desc" {
  description = "ec2_sg_ssh_proxy_desc"
  type        = string
}

variable "ec2_sg_ssh_proxy_port" {
  description = "ec2_sg_shh_proxy_port"
  type        = number
}

variable "ec2_sg_ssh_proxy_protocol" {
  description = "ec2_sg_ssh_proxy_protocol"
  type        = string
}

variable "ec2_sg_ssh_proxy_cidr" {
  description = "ec2_sg_shh_proxy_cidr"
  type        = string
}

variable "ec2_sg_egress_port" {
  description = "ec2_sg_egress_port"
  type        = number
}

variable "ec2_sg_egrress_protocol" {
  description = "ec2_sg_egrress_protocol"
  type        = number
}

variable "ec2_sg_egress_cidr" {
  description = "ec2_sg_egress_cidr"
  type        = string
}

variable "default_az_id" {
  description = "default_az_id"
  type        = string
}

variable "jenkins_instance_profile_name" {
  description = "jenkins_instance_profile_name"
  type        = string
}

variable "ec2_keypair_name" {
  description = "ec2_keypair_name"
  type        = string
}

variable "ec2_instanct_tag_val" {
  description = "ec2_instanct_tag_val"
  type        = string
}
