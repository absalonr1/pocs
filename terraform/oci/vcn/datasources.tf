data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}