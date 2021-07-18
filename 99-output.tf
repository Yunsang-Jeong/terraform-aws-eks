output "eks_cluster_id" {
  description = "The id of the eks cluster"
  value = aws_eks_cluster.this.id
}

output "eks_oidc_issuer" {
  description = "The arn of the oidc issuer"
  value = aws_eks_cluster.this.identity[0].oidc[0].issuer
}