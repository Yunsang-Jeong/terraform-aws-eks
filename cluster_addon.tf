# locals {
#   addons = {
#     vpc-cni = {
#       version = "v1.18.3-eksbuild.2"
#     }
#   }
# }

# ################################################################################
# # EKS: Addon

# resource "aws_eks_addon" "this" {
#   for_each = toset([
#     "vpc-cni",
#   ])

#   cluster_name = aws_eks_cluster.this.name
#   addon_name   = each.key
# }
# ################################################################################