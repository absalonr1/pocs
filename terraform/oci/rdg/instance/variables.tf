variable "tenancy_ocid"{}
variable "instance_shape"{}
variable "compartment_ocid"{}
variable "instance_image_ocid"{}
variable "instance_image_ocid_win"{}
variable "instance_image_ocid_linux_rdg_custom"{}
variable "private_subnet_id"{}
variable "public_subnet_id"{}
variable "region"{}
variable "vm_ssh_public_key" {}
variable "user_data" {
  default = <<EOF
#!/bin/bash -x
echo '################### start RDG #####################'
Oracle/Middleware/Oracle_Home/domain/bin/startJetty.sh
EOF
}


