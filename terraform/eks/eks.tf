resource "aws_iam_role" "jenkins" {
  name               = "eks-cluster-jenkins"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
  POLICY
}

resource "aws_iam_role_policy_attachment" "jenkins-EKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.jenkins.name

}
resource "aws_eks_cluster" "jenkins" {
  name     = "jenkins"
  role_arn = aws_iam_role.jenkins.arn
  vpc_config {
    subnet_ids = [
      aws_subnet.private-us-east-2a.id,
      aws_subnet.private-us-east-2b.id,
      aws_subnet.public-us-east-2a.id,
      aws_subnet.public-us-east-2b.id,
    ]
  }
  depends_on = [aws_iam_role_policy_attachment.jenkins-EKSClusterPolicy]
}
