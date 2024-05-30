resource "aws_iam_role" "nodes" {
  name = "eks-node-group"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nodes-EKSWorkerNode-Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name

}
resource "aws_iam_role_policy_attachment" "nodes-EKSCNI-Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name

}
resource "aws_iam_role_policy_attachment" "nodes-EKSContainerRegistry-ReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name

}
resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.jenkins.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids = [
    aws_subnet.private-us-east-2a.id,
    aws_subnet.private-us-east-2b.id
  ]
  // Could update type to ON_DEMAND for more stable nodes
  capacity_type = "SPOT"
  // For more production ready cluster use m5.large or better
  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 0
  }
  update_config {
    max_unavailable = 1
  }
  labels = {
    role = "private"
  }
  depends_on = [
    aws_iam_role_policy_attachment.nodes-EKSCNI-Policy,
    aws_iam_role_policy_attachment.nodes-EKSContainerRegistry-ReadOnly,
    aws_iam_role_policy_attachment.nodes-EKSWorkerNode-Policy
  ]
}

// Creating two different types of nodes. One that is public and one that is internal. This is useful when you want to keep some nodes internal facing only, like a dev environment
resource "aws_eks_node_group" "public-nodes" {
  cluster_name    = aws_eks_cluster.jenkins.name
  node_group_name = "public-nodes"
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids = [
    aws_subnet.public-us-east-2a.id,
    aws_subnet.public-us-east-2b.id
  ]
  // Could update type to ON_DEMAND for more stable nodes
  capacity_type = "SPOT"
  // For more production ready cluster use m5.large or better
  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 0
  }
  update_config {
    max_unavailable = 1
  }
  labels = {
    role = "public"
  }
  depends_on = [
    aws_iam_role_policy_attachment.nodes-EKSCNI-Policy,
    aws_iam_role_policy_attachment.nodes-EKSContainerRegistry-ReadOnly,
    aws_iam_role_policy_attachment.nodes-EKSWorkerNode-Policy
  ]
}

// Template example in case you wanted to add storage to the nodes
// For this example I decided not to include it
//resource "aws_launch_template" "eks-with-disks" {
//  name = "eks-with-disks"
//  key_name = "local-provisioner"
//  block_device_mappings {
//      device_name = "/dev/xvdb"
//      ebs {
//        volume_size = 50
//        volume_type = "gp2"
//      }
//  }
//  
//}
