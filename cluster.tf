################################################################################
# EKS: Cluster

resource "aws_eks_cluster" "this" {
  name     = "${var.name_prefix}-eks-cluseter"
  role_arn = aws_iam_role.cluster_role.arn
  bootstrap_self_managed_addons = true
  version  = "1.30"

  upgrade_policy {
    support_type = "STANDARD"
  }

  access_config {
    bootstrap_cluster_creator_admin_permissions = true
    authentication_mode                         = "API_AND_CONFIG_MAP"
  }

  # encryption_config {
  #   resources = ["secrets"]

  #   provider {
  #     key_arn = ""
  #   }
  # }

  vpc_config {
    endpoint_public_access  = false
    endpoint_private_access = true
    public_access_cidrs     = []
    subnet_ids = [
      module.network.subnet_ids["private-a"],
      module.network.subnet_ids["private-c"],
    ]
    security_group_ids = [module.cluster_sg.security_group_ids["cluster"]]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_role_aws_managed_policy,
  ]
}
################################################################################


################################################################################
# EKS: Security Group

module "cluster_sg" {
  source = "github.com/Yunsang-Jeong/terraform-aws-securitygroup"

  name_prefix = var.name_prefix
  vpc_id      = module.network.vpc_id
  security_groups = [
    {
      identifier  = "cluster"
      description = "the security group for eks-cluster"
    },
  ]
}
################################################################################


################################################################################
# EKS: IAM Role

resource "aws_iam_role" "cluster_role" {
  name               = "${var.name_prefix}-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.clsuter_role.json
}

data "aws_iam_policy_document" "clsuter_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}
################################################################################


################################################################################
# EKS: IAM Role Policy

resource "aws_iam_role_policy_attachment" "cluster_role_aws_managed_policy" {
  for_each = toset([
    "AmazonEKSClusterPolicy",
    # "AmazonEKSVPCResourceController",
  ])

  role       = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/${each.key}"
}
################################################################################


################################################################################
# EKS: Access Entry

resource "aws_eks_access_entry" "this" {
  cluster_name      = aws_eks_cluster.this.name
  type              = "STANDARD"
  principal_arn     = "arn:aws:iam::846802517350:role/aws-reserved/sso.amazonaws.com/ap-northeast-2/AWSReservedSSO_AdministratorAccess_0b210601f63ba511"
}

resource "aws_eks_access_policy_association" "this" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = "arn:aws:iam::846802517350:role/aws-reserved/sso.amazonaws.com/ap-northeast-2/AWSReservedSSO_AdministratorAccess_0b210601f63ba511"
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type       = "cluster"
  }
}
################################################################################

