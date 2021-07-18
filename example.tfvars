vpc_id                               = "vpc-"
subnet_ids                           = [ ]
cluster_name                         = "CLUSTER"
flag_access_to_endpoint_from_private = true
flag_access_to_endpoint_from_public  = true
allow_ip_address                     = ["1.2.3.4/32"]
node_groups = [
  {
    identifier       = "ng-1"
    name             = "ng-1"
    disk_size        = "20"
    ami_type         = "AL2_x86_64"
    instance_types   = "t3.small"
    labels           = null
    ec2_ssh_key      = "key-an2-imys-poc"
    scale_desire     = "2"
    scale_max        = "2"
    scale_min        = "2"
    name_tag_postfix = "ng-1"
  }
]