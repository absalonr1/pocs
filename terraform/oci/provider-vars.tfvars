# 

variable "tenancy_ocid" {
    default ="ocid1.tenancy.oc1..aaaaaaaahww27qgv44s5ibdur2pdshfheobg7je6rsawkqwr3wrilff7mn4q"
}

# luisopazo@gmail.com
variable "user_ocid" {
    default ="ocid1.user.oc1..aaaaaaaah2bclsokfnv5k5ucqi2uqfgto2tdnydw5edibjvrnlfaofhmjjba"
}
variable "region" {
    default ="us-ashburn-1"
}

# root compartment (absalon)
variable "compartment_ocid" {
    default ="ocid1.tenancy.oc1..aaaaaaaahww27qgv44s5ibdur2pdshfheobg7je6rsawkqwr3wrilff7mn4q"
}

variable "fingerprint" {
    default ="f4:c6:62:e9:d4:f6:ec:ae:0a:b2:5e:5a:6a:67:76:cf"
}

variable "private_key_path" {
    default ="/home/absalon/.oci/"
}

variable "ssh_public_key" {
    default ="oci_api_key.pem"
}

variable "ssh_private_key" {
    default ="oci_api_key.pem"
}