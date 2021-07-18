:warning:

# Overview

AWS EKS에 대한 Terraform 모듈입니다. 다음의 항목을 프로비저닝하고자 합니다.
 - AWS IAM Role for EKS cluster and Worker node
 - AWS EKS cluster
 - AWS EKS managed worker node
 
하단의 내용은 `terraform-docs`에 의해 생성되었습니다.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.25.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.25.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_ip_address"></a> [allow\_ip\_address](#input\_allow\_ip\_address) | List of IP Address to permit access. | `list(string)` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of eks cluster | `string` | n/a | yes |
| <a name="input_cluster_name_postfix"></a> [cluster\_name\_postfix](#input\_cluster\_name\_postfix) | The postfix of cluster name | `string` | `""` | no |
| <a name="input_flag_access_to_endpoint_from_private"></a> [flag\_access\_to\_endpoint\_from\_private](#input\_flag\_access\_to\_endpoint\_from\_private) | If true, the endpoint of control-plane wiil be only access from the VPC | `bool` | `true` | no |
| <a name="input_flag_access_to_endpoint_from_public"></a> [flag\_access\_to\_endpoint\_from\_public](#input\_flag\_access\_to\_endpoint\_from\_public) | If true, the endpoint of control-plane can be access from remote | `bool` | `true` | no |
| <a name="input_global_additional_tag"></a> [global\_additional\_tag](#input\_global\_additional\_tag) | Additional tags for all resources. | `map(string)` | `{}` | no |
| <a name="input_name_tag_convention"></a> [name\_tag\_convention](#input\_name\_tag\_convention) | The name tag convention of all resources. | <pre>object({<br>    project_name = string<br>    stage        = string<br>  })</pre> | <pre>{<br>  "project_name": "tf",<br>  "stage": "poc"<br>}</pre> | no |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | The worker node groups of AWS EKS | <pre>list(object({<br>    identifier       = string<br>    name             = string<br>    disk_size        = number<br>    ami_type         = string<br>    instance_types   = string<br>    labels           = map(string)<br>    ec2_ssh_key      = string<br>    scale_desire     = number<br>    scale_max        = number<br>    scale_min        = number<br>    name_tag_postfix = string<br>  }))</pre> | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The id of subnets where you want to place compute resources | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of vpc where you want to place eks cluster | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_cluster_id"></a> [eks\_cluster\_id](#output\_eks\_cluster\_id) | The id of the eks cluster |
| <a name="output_eks_oidc_issuer"></a> [eks\_oidc\_issuer](#output\_eks\_oidc\_issuer) | The arn of the oidc issuer |

## Example
```hcl
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
```
<!-- END_TF_DOCS -->