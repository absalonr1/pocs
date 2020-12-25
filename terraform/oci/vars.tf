variable "mcr_tenancy_ocid"{

}
variable "mcr_user_ocid"{

}
variable "mcr_fingerprint" {

}
variable "mcr_private_key_path" {

}
variable "personal_tenancy_ocid"{

}
variable "personal_user_ocid" {

}
variable "personal_fingerprint"{

}
variable "personal_private_key_path" {
}
variable "provider_flag" {
}

variable "mcr_compartment_ocid" {
}

variable "personal_compartment_ocid" {
}

variable "region" {
    default ="us-ashburn-1"
}

# root compartment (absalon)
#variable "compartment_ocid" {
    # Personal
    #default ="ocid1.tenancy.oc1..aaaaaaaahww27qgv44s5ibdur2pdshfheobg7je6rsawkqwr3wrilff7mn4q"
    #ladmcr
    #default="ocid1.compartment.oc1..aaaaaaaahr5yytqlt3bdb7vv4r5ngr6ahe4sj2kpqkq6bqsdrdi64nvrbc3q"
#    default= provider_flag == "mcr" ? var.mcr_compartment_ocid : var.personal_compartment_ocid 
#}

#variable "tenancy_ocid" {
    
    #personal
    #default ="ocid1.tenancy.oc1..aaaaaaaahww27qgv44s5ibdur2pdshfheobg7je6rsawkqwr3wrilff7mn4q"
    
    #ladmcr
    #default = "ocid1.tenancy.oc1..aaaaaaaavl2ndgiiefoo2u4a7atlq2czcwyiu5zzb6rzwwpeyt5o2xmtaxwa"
#    default= provider_flag == "mcr" ? var.mcr_tenancy_ocid : var.personal_tenancy_ocid 
#}

# ---- 



# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.provider_flag == "mcr" ? var.mcr_tenancy_ocid : var.personal_tenancy_ocid
}

# Output the result
output "show-ads" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}



data "oci_identity_availability_domain" "ad" {
  compartment_id = var.provider_flag == "mcr" ? var.mcr_tenancy_ocid : var.personal_tenancy_ocid
  ad_number      = 1
}

