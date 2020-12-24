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

# ---- 

variable "instance_image_ocid" {
  type = map(string)

  default = {
    # See https://docs.us-phoenix-1.oraclecloud.com/images/
    # Oracle-provided image "Oracle-Linux-7.5-2018.10.16-0"
    us-phoenix-1   = "ocid1.image.oc3.us-gov-phoenix-1.aaaaaaaablheqkh4k2mo4l5wfnpg2t5zuokmgai5cex6kell4epiio5yi6lq"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaaf2wxqc6ee5axabpbandk6ji27oyxyicatqw5iwkrk76kecqrrdyq"
    
  }
}

variable "instance_shape" {
  default = "VM.Standard2.1"
}

data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}