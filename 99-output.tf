output "eks_oidc_issuer" {
  value = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

output "eks_id" {
  value = aws_eks_cluster.this.id
}