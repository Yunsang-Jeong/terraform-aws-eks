resource "aws_eks_cluster" "this" {
  name     = join("-", compact(["eks", local.name_tag_middle, "cluster", var.name_tag_postfix]))

  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = [module.security_groups.security_group["cluster"].id]
    endpoint_private_access = var.flag_access_to_endpoint_from_private
    endpoint_public_access  = var.flag_access_to_endpoint_from_public
    public_access_cidrs     = var.allow_ip_address
  }

  enabled_cluster_log_types = []

  kubernetes_network_config {
    service_ipv4_cidr = "172.20.0.0/16"
  }

  tags = merge(
    var.global_additional_tag,
    {
      "Name" = join("-", compact(["eks", local.name_tag_middle, "cluster", var.name_tag_postfix]))
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
  ]
}