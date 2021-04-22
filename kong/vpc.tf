# Create a VPC
resource "aws_vpc" "kong_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  #main_route_table_id - The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table by using an aws_main_route_table_association.
  #default_network_acl_id - The ID of the network ACL created by default on VPC creation
  #default_security_group_id - The ID of the security group created by default on VPC creation
  #default_route_table_id 

  tags = {
    Name = "kong_vpc"
  }
}


resource "aws_internet_gateway" "igw_kong" {
  vpc_id = aws_vpc.kong_vpc.id

  tags = {
    Name = "igw_kong"
  }
}

resource "aws_subnet" "subnet_kong_1" {
  vpc_id            = aws_vpc.kong_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet_kong_1"
  }

}
resource "aws_subnet" "subnet_kong_2" {
  vpc_id            = aws_vpc.kong_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "subnet_kong_2"
  }

}

resource "aws_route_table_association" "subnet_association_priv" {
  subnet_id      = aws_subnet.subnet_kong_2.id
  route_table_id = aws_route_table.route_table_kong.id
}

resource "aws_route_table" "route_table_kong" {
  vpc_id = aws_vpc.kong_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_kong.id
  }

  tags = {
    Name = "route_table_kong"
  }

}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.subnet_kong_1.id
  route_table_id = aws_route_table.route_table_kong.id
}