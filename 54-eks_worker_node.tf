resource "aws_eks_node_group" "this" {
  for_each = { for ng in var.node_groups : ng.identifier => ng }

  cluster_name    = var.cluster_name
  node_group_name = each.value.name
  node_role_arn   = aws_iam_role.worker.arn
  subnet_ids      = var.subnet_ids

  ami_type       = each.value.ami_type         # Must be "AL2_x86_64" or "AL2_x86_64_GPU" or "AL2_ARM_64"
  disk_size      = each.value.disk_size        # 20
  instance_types = [each.value.instance_types] # ["t3.medium"]
  labels         = each.value.labels

  # launch_template {
  #   id = "value"
  #   name = "value"
  #   version = "value"
  # }

  remote_access {
    ec2_ssh_key = each.value.ec2_ssh_key
    # source_security_group_ids = [ module.security_groups.security_group["worker"].id ]
  }

  scaling_config {
    desired_size = each.value.scale_desire
    max_size     = each.value.scale_max
    min_size     = each.value.scale_min
  }

  tags = merge(
    var.global_additional_tag,
    local.kubernetes_tag,
    {
      "Name" = join("-", compact(["ng", local.name_tag_middle, "eks", "worker-node", each.value.name_tag_postfix]))
    }
  )

  depends_on = [
    aws_eks_cluster.this,
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}