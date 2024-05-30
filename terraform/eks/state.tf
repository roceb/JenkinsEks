resource "aws_s3_bucket" "infra_jenkins_state" {
  bucket = "infra-jenkins-terraform-state"
  server_side_encryption_configuration {
    rule {
      bucket_key_enabled = false
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    Name = "jenkins state"
  }

}
// We can store state on s3 so that we can sync state across users
//terraform {
//  backend "s3" {
//    bucket = "infra-jenkins-terraform-state"
//    region = "us-east-2"
//    key    = "jenkins-server/terraform.tfstate"
//  }
//}
