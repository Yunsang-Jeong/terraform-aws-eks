module "security_groups" {
  source              = "github.com/Yunsang-Jeong/terraform-aws-scg?ref=v1.0.0"
  name_tag_convention = var.name_tag_convention
  vpc_id              = var.vpc_id
  security_groups = [
    {
      identifier       = "cluster"
      description      = "Communicate between control-palne and compute resources"
      name_tag_postfix = "cluster"
      additional_tag   = local.kubernetes_tag
      ingresses        = []
      }, {
      identifier       = "worker"
      description      = "Communicate between control-palne and compute resources"
      name_tag_postfix = "worker"
      additional_tag   = local.kubernetes_tag
      ingresses = []
      }
  ]
}