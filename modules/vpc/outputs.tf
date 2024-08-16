output "vpc_id" {
  value       = aws_vpc.xquic.id
  description = "The ID of the created Virtual Private Cloud (VPC)"
}

output "public_subnet_ids" {
  value       = aws_subnet.public_subnets[*].id
  description = "The IDs of the public subnets created within the VPC"
}

output "private_subnet_ids" {
  value       = aws_subnet.private_subnets[*].id
  description = "The IDs of the private subnets created within the VPC"
}
