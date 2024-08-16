# Define the VPC
resource "aws_vpc" "xquic" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = local.vpc_dns_hostnames_support
  enable_dns_support   = local.vpc_dns_support
  instance_tenancy     = local.vpc_instance_tenancy
  tags = {
    Name = var.vpc_name
  }
}

# Define public subnets
resource "aws_subnet" "public_subnets" {
  count                   = var.public_subnet_count
  vpc_id                  = aws_vpc.xquic.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = element(var.availability_zones, count.index % length(var.availability_zones))
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}-public-subnet-${count.index + 1}"
  }
}

# Define private subnets
resource "aws_subnet" "private_subnets" {
  count             = var.private_subnet_count
  vpc_id            = aws_vpc.xquic.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 16)
  availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))
  tags = {
    Name = "${var.prefix}-private-subnet-${count.index + 1}"
  }
}

# Define internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.xquic.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}

# Define NAT gateway
resource "aws_nat_gateway" "nat_gateway" {
  count         = var.nat_gateway_count
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)
  allocation_id = element(aws_eip.nat_eip[*].id, count.index)
  tags = {
    Name = "${var.prefix}-nat-gateway-${count.index + 1}"
  }
}

# Define EIP for NAT gateway
resource "aws_eip" "nat_eip" {
  count = var.nat_gateway_count
}

# Define public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.xquic.id

  route {
    cidr_block = local.local_route
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.prefix}-public-route-table"
  }
}

# Associate public route table with public subnets
resource "aws_route_table_association" "public_subnet_associations" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# Define private route table
resource "aws_route_table" "private_route_table" {
  count  = var.private_subnet_count
  vpc_id = aws_vpc.xquic.id

  route {
    cidr_block     = local.local_route
    nat_gateway_id = element(aws_nat_gateway.nat_gateway[*].id, count.index % var.nat_gateway_count)
  }

  tags = {
    Name = "${var.prefix}-private-route-table-${count.index + 1}"
  }
}

# Associate private route table with private subnets
resource "aws_route_table_association" "private_subnet_associations" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}

