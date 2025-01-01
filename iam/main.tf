resource "aws_iam_user" "admin-user" {
  name = var.name[count.index]
  tags = {
    description = var.tags[count.index]
  }
  count = length(var.tags)
}


resource "aws_iam_group" "project-alpha" {
  name = "ProjectAlpha"

}

resource "aws_iam_user_group_membership" "projectAlpha" {
  user   = var.name[count.index]
  groups = [aws_iam_group.project-alpha.name]
  count  = length(var.tags)
}

# resource "aws_iam_policy" "Ec2InstanceAccess" {
#   name        = "EC2FullAccess"
#   policy      = file("aws_policy.json")
#   description = "Allowing Project Alpha's team full access to EC2 Instance"
# }

data "aws_iam_policy" "existing-policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}


resource "aws_iam_group_policy_attachment" "project-policy" {
  group      = aws_iam_group.project-alpha.arn
  policy_arn = data.aws_iam_policy.existing-policy.arn
  depends_on = [data.aws_iam_policy.existing-policy]
}


output "arn" {
  value = data.aws_iam_policy.existing-policy.arn
}
