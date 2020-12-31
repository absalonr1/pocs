variable "tenancy_ocid"{}
variable "user_ocid"{}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "vm_ssh_public_key"{}

variable "instance_image_ocid" {
  type = map(string)

  default = {
    # See https://docs.us-phoenix-1.oraclecloud.com/images/
    # Oracle-provided image "Oracle-Linux-7.5-2018.10.16-0"
    us-phoenix-1   = "ocid1.image.oc3.us-gov-phoenix-1.aaaaaaaablheqkh4k2mo4l5wfnpg2t5zuokmgai5cex6kell4epiio5yi6lq"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaaf2wxqc6ee5axabpbandk6ji27oyxyicatqw5iwkrk76kecqrrdyq"
    
  }
}
variable "instance_image_ocid_win" {
  type = map(string)

  default = {
    # See https://docs.us-phoenix-1.oraclecloud.com/images/
    # Windows-Server-2019-Standard-Edition-VM-Gen2-2020.10.22-0
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaayxmorhjrkcraeoeaid2ijneuwtupddliy3oe7yv7kbjwinnop3rq"
    
  }
}


variable "instance_image_ocid_linux_rdg_custom" {
  type = map(string)

  default = {
    # See https://docs.us-phoenix-1.oraclecloud.com/images/
    # Oracle-provided image "Oracle-Linux-7.5-2018.10.16-0" 
    # Incluye instalacion de RDG 5.8
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaaraizp7oxtm47pk25gicdwjiwj7ar6s2eef5xcgxgkippu5rj7xsq"
    
  }
}
variable "instance_shape" {
  default = "VM.Standard2.1"
}




variable "db_system_shape"{
  default="VM.Standard2.1"
}