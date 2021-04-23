
variable "health_check_interval" {
  description = "Seconds between health checks"
  type        = string

  # Terraform default is 30
  default = 5
}

variable "health_check_matcher" {
  description = "HTTP Code(s) that result in a successful response from a target (comma delimited)"
  type        = string

  default = 200
}

variable "health_check_timeout" {
  description = "Seconds waited before a health check fails"
  type        = string

  # Terraform default is 5
  default = 3
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutives checks before a unhealthy target is considered healthy"
  type        = string

  # Terraform default is 5
  default = 5
}
variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive checks before considering a target unhealthy"
  type        = string

  # Terraform default is 2
  default = 2
}

variable "idle_timeout" {
  description = "Seconds a connection can idle before being disconnected"
  type        = string

  # Terraform default is 60
  default = 60
}

variable "ssl_policy" {
  description = "SSL Policy for HTTPS Listeners"
  type        = string

  default = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "kong_vm_user_data"{

  default = <<-EOF
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

}

variable "ami" {
  type = map(string)

  default = {
    prod = "ami-0742b4e673072066f"
    dev = "ami-0742b4e673072066f"
    poc = "ami-0742b4e673072066f"
  }
}


# https://docs.konghq.com/enterprise/2.3.x/sizing-guidelines/
variable "instance_type" {
  type = map(string)

  default = {
    prod = "m5.large"
    dev = "t2.micro"
    poc = "t2.micro"
  }
}

# https://docs.konghq.com/enterprise/0.32-x/kong-implementation-checklist/
variable "db_instance_type" {
  type = map(string)

  default = {
    prod = "db.r6g.large"
    dev = "db.m6g.large"
    poc = "db.t2.micro"
  }
}

variable "environment" {
  type = string

  default = "poc"
  #default = "prod"
  #default = "dev"

}

variable "db_password" {
  default = "password"
}

variable "db_username" {
  default = "postgres"
}

# Postgres
variable "db_engine_version" {
  default = "11.5"
}


