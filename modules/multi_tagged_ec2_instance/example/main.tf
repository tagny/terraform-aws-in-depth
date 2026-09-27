data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "test_instances" {
  source                 = "../"
  name_prefix            = "test_instance"
  instance_count         = 5
  subnet_id              = data.aws_subnets.default.ids[0]
  enable_systems_manager = true
  tags = {
    "author" : "Terraform AWS in depth"
    "BillingGroup" = "mygroup"
  }
}

# Example: Granting Read-Only access to S3
resource "aws_iam_role_policy_attachment" "s3_read" {
  role       = module.test_instances.aws_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

output "aws_instance_arns" {
  value = module.test_instances.aws_instance_arns
}
