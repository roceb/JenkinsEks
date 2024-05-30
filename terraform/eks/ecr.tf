resource "aws_ecr_repository" "ecr" {
  name                 = "indev"
  image_tag_mutability = "MUTABLE"
  encryption_configuration {
    encryption_type = "KMS"
  }
  image_scanning_configuration {
    scan_on_push = true
  }

}
output "ecr" {
  value = aws_ecr_repository.ecr.repository_url
}

resource "aws_ecr_repository" "jenkins" {
  name                 = "jenkins"
  image_tag_mutability = "MUTABLE"
  encryption_configuration {
    encryption_type = "KMS"
  }
  image_scanning_configuration {
    scan_on_push = true
  }

}
output "jenkins" {
  value = aws_ecr_repository.jenkins.repository_url
}
