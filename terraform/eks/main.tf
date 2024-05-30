provider "aws" {
  //region = local.region
  region = "us-east-2"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }
}


