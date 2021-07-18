resource "aws_iam_role" "cluster" {
  name = join("-", compact(["role", local.name_tag_middle, "eks", "cluster"]))
  assume_role_policy = data.aws_iam_policy_document.cluster.json
  tags               = merge(
    local.kubernetes_tag, {
    "Name" = join("-", compact(["role", local.name_tag_middle, "eks", "cluster"])) 
    }
  )
  lifecycle {
    ignore_changes = [name]
  }
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

data "aws_iam_policy_document" "cluster" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}