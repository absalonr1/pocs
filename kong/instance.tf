resource "aws_eip" "eip_kong_1" {

  instance   = aws_instance.kong_vm_1.id
  vpc        = true
  depends_on = [aws_internet_gateway.igw_kong]
}
resource "aws_eip" "eip_kong_2" {

  instance   = aws_instance.kong_vm_2.id
  vpc        = true
  depends_on = [aws_internet_gateway.igw_kong]
}


resource "aws_instance" "kong_vm_1" {
  ami                         = "ami-0742b4e673072066f"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  #key_name - (Optional) Key name of the Key Pair to use for the instance; which can be managed using the aws_key_pair resource.
  key_name        = "aopazo-kong"
  security_groups = [aws_security_group.sg_kong.id]
  subnet_id       = aws_subnet.subnet_kong_1.id

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
    
    # INICIO : lo siguiente es solo para pruebas. Bo usa BD
    touch test
    kong config init
    echo "admin_listen = 0.0.0.0:8001" >> /etc/kong/kong.conf
    echo "database = off" >> /etc/kong/kong.conf
    echo "declarative_config = /kong.yml"  >> /etc/kong/kong.conf
    # FIN  
    /usr/local/bin/kong start [-c /etc/kong/kong.conf]
    
	EOF

  tags = {
    Name = "kong_vm_1"
  }
  
}

resource "aws_instance" "kong_vm_2" {
  ami                         = "ami-0742b4e673072066f"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  #key_name - (Optional) Key name of the Key Pair to use for the instance; which can be managed using the aws_key_pair resource.
  key_name        = "aopazo-kong"
  security_groups = [aws_security_group.sg_kong.id]
  subnet_id       = aws_subnet.subnet_kong_2.id

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
    
    # INICIO : lo siguiente es solo para pruebas. Bo usa BD
    touch test
    kong config init
    echo "admin_listen = 0.0.0.0:8001" >> /etc/kong/kong.conf
    echo "database = off" >> /etc/kong/kong.conf
    echo "declarative_config = /kong.yml"  >> /etc/kong/kong.conf
    # FIN  
    /usr/local/bin/kong start [-c /etc/kong/kong.conf]

	EOF

  tags = {
    Name = "kong_vm_2"
  }
  
}

output "public_ip1" {
  description = ""
  value       =   aws_instance.kong_vm_1.public_ip
}

output "public_ip2" {
  description = ""
  value       =   aws_instance.kong_vm_2.public_ip
}

/*
output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       =   aws_instance.kong_vm_2.public_ip
}

output "private_dns" {
  description = "List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = aws_instance.kong_vm_2.private_dns
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = aws_instance.kong_vm_2.private_ip
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = aws_instance.kong_vm_2.public_dns
}
*/


