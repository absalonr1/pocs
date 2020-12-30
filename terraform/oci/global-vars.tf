variable "tenancy_ocid"{

}
variable "user_ocid"{

}
variable "fingerprint" {

}
variable "private_key_path" {

}


variable "compartment_ocid" {
}

variable "region" {
    
}


variable "vm_ssh_public_key"{
  
}

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