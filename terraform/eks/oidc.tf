data "tls_certificate" "eks" {
  url = aws_eks_cluster.jenkins.identity[0].oidc[0].issuer
}

// TODO: Test this part before using
resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.jenkins.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test     = "StringEquals"
      values   = ["system:serviceaccount:default:jenkins"]
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
    }
    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "oidc" {
  assume_role_policy = data.aws_iam_policy_document._oidc_assume_role_policy.json
  name               = "oidc"
}

// Please review and update the permissions if being used in production 
// TODO: Permissions are too opened
resource "aws_iam_policy" "eks_oidc_policy" {
  name = "eks-oidc-policy"
  policy = jsonencode({
    Statement = [{
      Action = [
        "*"
      ]
      Effect   = "Allow"
      Resource = "arn:aws:*"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "oidc_attach" {
  role       = aws_iam_role.oidc.name
  policy_arn = aws_iam_policy.eks_oidc_policy.arn
}

output "oidc_policy_arn" {
  value = aws_iam_role.oidc.arn
}
