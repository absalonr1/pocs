# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.provider_flag == "mcr" ? var.mcr_tenancy_ocid : var.personal_tenancy_ocid
}


data "oci_identity_availability_domain" "ad" {
  compartment_id = var.provider_flag == "mcr" ? var.mcr_tenancy_ocid : var.personal_tenancy_ocid
  ad_number      = 1
}