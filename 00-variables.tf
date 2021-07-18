########################################
# Shared
variable "name_tag_convention" {
  description = "The name tag convention of all resources."
  type = object({
    project_name = string
    stage        = string
  })
  default = {
    project_name = "tf"
    stage        = "poc"
  }
}

variable "global_additional_tag" {
  description = "Additional tags for all resources."
  type        = map(string)
  default     = {}
}
########################################

########################################
# EKS - cluster
variable "cluster_name_postfix" {
  description = "The postfix of cluster name"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The id of vpc where you want to place eks cluster"
  type        = string
}

variable "subnet_ids" {
  description = "The id of subnets where you want to place compute resources"
  type        = list(string)
}

variable "cluster_name" {
  description = "The name of eks cluster"
  type        = string
}

variable "flag_access_to_endpoint_from_private" {
  description = "If true, the endpoint of control-plane wiil be only access from the VPC"
  type        = bool
  default     = true
}

variable "flag_access_to_endpoint_from_public" {
  description = "If true, the endpoint of control-plane can be access from remote"
  type        = bool
  default     = true
}

variable "allow_ip_address" {
  description = "List of IP Address to permit access."
  type        = list(string)
  default     = []
}
########################################


########################################
# EKS - node group
variable "node_groups" {
  description = "The worker node groups of AWS EKS"
  type = list(object({
    identifier       = string
    name             = string
    disk_size        = number
    ami_type         = string
    instance_types   = string
    labels           = map(string)
    ec2_ssh_key      = string
    scale_desire     = number
    scale_max        = number
    scale_min        = number
    name_tag_postfix = string
  }))
}
########################################