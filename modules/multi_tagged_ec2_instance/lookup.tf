data "aws_ami" "ubuntu" {
  # This is the AWS account for Cannonical, the makers of Ubuntu.
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "ssm_arn" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy"
}
