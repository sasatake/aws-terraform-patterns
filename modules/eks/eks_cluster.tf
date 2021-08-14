resource "aws_eks_cluster" "main" {
  name     = "${var.prefix}-cluster"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids              = var.subnet_id_list
    security_group_ids      = [aws_security_group.eks_cluster.id]
    endpoint_public_access  = true
    endpoint_private_access = false
  }

  version = "1.21"

  depends_on = [
    aws_security_group.eks_cluster,
    aws_iam_role.eks_cluster,
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_cluster_vpc_resource_policy,
  ]
}

resource "aws_eks_fargate_profile" "app" {
  cluster_name           = aws_eks_cluster.main.name
  fargate_profile_name   = "${var.prefix}-cluster-node-app"
  pod_execution_role_arn = aws_iam_role.eks_pod.arn
  subnet_ids             = var.private_subnet_id_list

  selector {
    namespace = "app"
  }
}

resource "aws_eks_fargate_profile" "ope" {
  cluster_name           = aws_eks_cluster.main.name
  fargate_profile_name   = "${var.prefix}-cluster-node-ope"
  pod_execution_role_arn = aws_iam_role.eks_pod.arn
  subnet_ids             = var.private_subnet_id_list

  selector {
    namespace = "default"
  }

  selector {
    namespace = "kube-system"
  }

  selector {
    namespace = "kubernetes-dashboard"
  }
}
