# resource "aws_cloud9_environment_ec2" "bastion" {
#   name          = "${var.name_prefix}-eks-bastion"
#   instance_type = "t3.micro"
#   image_id      = "amazonlinux-2023-x86_64"
#   subnet_id     = module.network.subnet_ids["public-a"]
# }