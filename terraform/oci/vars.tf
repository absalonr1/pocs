variable "region" {
    default ="us-ashburn-1"
}

# root compartment (absalon)
variable "compartment_ocid" {
    # Personal
    #default ="ocid1.tenancy.oc1..aaaaaaaahww27qgv44s5ibdur2pdshfheobg7je6rsawkqwr3wrilff7mn4q"
    #ladmcr
    default="ocid1.compartment.oc1..aaaaaaaahr5yytqlt3bdb7vv4r5ngr6ahe4sj2kpqkq6bqsdrdi64nvrbc3q"
}

variable "tenancy_ocid" {
    
    #personal
    #default ="ocid1.tenancy.oc1..aaaaaaaahww27qgv44s5ibdur2pdshfheobg7je6rsawkqwr3wrilff7mn4q"
    
    #ladmcr
    default = "ocid1.tenancy.oc1..aaaaaaaavl2ndgiiefoo2u4a7atlq2czcwyiu5zzb6rzwwpeyt5o2xmtaxwa"
}

# ---- 



# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

# Output the result
output "show-ads" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}


data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

