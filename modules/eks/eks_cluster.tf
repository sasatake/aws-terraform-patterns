resource "aws_eks_cluster" "main" {
  name     = "${var.prefix}-cluster"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids         = [aws_subnet.private_subnet_01.id, aws_subnet.private_subnet_02.id]
    security_group_ids = [aws_security_group.eks_cluster.id]
  }

  depends_on = [
    aws_subnet.private_subnet_01,
    aws_subnet.private_subnet_02,
    aws_security_group.eks_cluster,
    aws_iam_role.eks_cluster,
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_pods_policy,
  ]
}
