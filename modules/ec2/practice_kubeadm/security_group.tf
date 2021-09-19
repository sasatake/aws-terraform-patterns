resource "aws_security_group" "k8s_node" {
  name        = "${var.prefix}-sg-k8s-node"
  description = "Allow Cluster Node Connections"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "Allow Kubelet Connections"
      from_port        = 10250
      to_port          = 10250
      protocol         = "tcp"
      cidr_blocks      = [var.vpc_cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    }
  ]

  egress = [
    {
      description      = "Allow Outbound HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name            = "${var.prefix}-sg-k8s-node"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
  }
}

resource "aws_security_group" "k8s_master_node" {
  name        = "${var.prefix}-sg-k8s-master-node"
  description = "Allow Cluster Master Node Connections"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "Allow Kubernetes API server Connections"
      from_port        = 6443
      to_port          = 6443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "Allow Etcd Server Client API Connections"
      from_port        = 2379
      to_port          = 2380
      protocol         = "tcp"
      cidr_blocks      = [var.vpc_cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "Allow Kube Scheduler Connections"
      from_port        = 10251
      to_port          = 10251
      protocol         = "tcp"
      cidr_blocks      = [var.vpc_cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    },
    {
      description      = "Allow Kube Controller Manager Connections"
      from_port        = 10252
      to_port          = 10252
      protocol         = "tcp"
      cidr_blocks      = [var.vpc_cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    }
  ]

  tags = {
    Name            = "${var.prefix}-sg-k8s-master-node"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
  }
}

resource "aws_security_group" "k8s_worker_node" {
  name        = "${var.prefix}-sg-k8s-worker-node"
  description = "Allow Cluster Worker Node Connections"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "Allow NodePort Service Connections"
      from_port        = 30000
      to_port          = 32767
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name            = "${var.prefix}-sg-k8s-worker-node"
    ProvisionedBy   = "Terraform"
    ProvisionedFrom = "local"
  }
}
