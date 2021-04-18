terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
  profile = "devaccess"
}


# Create a VPC
resource "aws_vpc" "kong_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

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

resource "aws_subnet" "pub_subnet_kong" {
  vpc_id     = aws_vpc.kong_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "pub_subnet_kong"
  }

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
  subnet_id      = aws_subnet.pub_subnet_kong.id
  route_table_id = aws_route_table.route_table_kong.id
}

resource "aws_security_group" "sg_kong" {
name = "sg_kong_allow-all-sg"
vpc_id = aws_vpc.kong_vpc.id
ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
  }

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
  }
// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

tags = {
    Name = "sg_kong"
  }
}

#-----------------------------

resource "aws_eip" "eip_kong" {
  instance   = aws_instance.kong_vm.id
  vpc        = true
  depends_on = [aws_internet_gateway.igw_kong]
}

resource "aws_instance" "kong_vm" {
  ami                         = "ami-0742b4e673072066f"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  #key_name - (Optional) Key name of the Key Pair to use for the instance; which can be managed using the aws_key_pair resource.
  key_name = "aopazo-kong"
  security_groups = [aws_security_group.sg_kong.id]
  subnet_id = aws_subnet.pub_subnet_kong.id

  user_data = <<-EOF
		#! /bin/bash
    wget https://bintray.com/kong/kong-rpm/download_file?file_path=amazonlinux/amazonlinux2/kong-2.4.0.aws.amd64.rpm -o kong-2.4.0.aws.amd64.rpm
    sudo yum install kong-2.4.0.aws.amd64.rpm --nogpgcheck
    sudo yum update -y
    sudo yum install -y wget
    wget https://bintray.com/kong/kong-rpm/rpm -O bintray-kong-kong-rpm.repo
    sed -i -e 's/baseurl.*/&\/amazonlinux\/amazonlinux'/ bintray-kong-kong-rpm.repo
    sudo mv bintray-kong-kong-rpm.repo /etc/yum.repos.d/
    sudo yum update -y
    sudo yum install -y kong
    cp /etc/kong/kong.conf.default /etc/kong/kong.conf
	EOF

  tags = {
    Name = "kong_vm"
  }
}

#-----------------
resource "aws_subnet" "priv_subnet_kong" {
  vpc_id     = aws_vpc.kong_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "priv_subnet_kong"
  }

}


resource "aws_route_table_association" "subnet_association_priv" {
  subnet_id      = aws_subnet.priv_subnet_kong.id
  route_table_id = aws_route_table.route_table_kong.id
}

resource "aws_db_instance" "kong_bd" {
  publicly_accessible = true
  name                = "kongbd"
  allocated_storage    = 100
  db_subnet_group_name = "kong_bd_subnet_group"
  engine               = "postgres"
  engine_version       = "11.5"
  identifier           = "kongbd"
  instance_class       = "db.t2.micro"
  password             = "password"
  skip_final_snapshot  = true
  #storage_encrypted    = true
  username             = "postgres"
  depends_on            = [aws_db_subnet_group.kong_bd_subnet_group]
  vpc_security_group_ids = [aws_security_group.sg_kong.id]
}

#Leeme: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html#USER_VPC.Subnets
resource "aws_db_subnet_group" "kong_bd_subnet_group" {
  name       = "kong_bd_subnet_group"
  subnet_ids = [aws_subnet.pub_subnet_kong.id, aws_subnet.priv_subnet_kong.id]
}

#output "subnet_group_id" {
#  value       = join("", aws_db_subnet_group.default.*.id)
#  description = "ID of the created Subnet Group"
#}