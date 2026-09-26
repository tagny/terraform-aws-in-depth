output "aws_instance_arns" {
  description = "The AWS Resource Name for the instances."
  value       = [for instance in aws_instance.hello_world : instance.arn]
}
output "aws_instance_ips" {
  description = "The IP Address for the private network interface on the instances."
  value       = [for instance in aws_instance.hello_world : instance.private_ip]
}
output "aws_instances" {
  description = "The entire instance resources."
  value       = aws_instance.hello_world
}

output "aws_instance_role" {
  description = "Now our role can be accessed by others, who can then attach their own policies to it."
  value       = aws_iam_role.main
}
