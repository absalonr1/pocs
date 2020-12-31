#https://www.terraform.io/docs/configuration/outputs.html
output "vcn_id" {
  value=oci_core_vcn.test_vcn.id
}

output "public_subnet_id" {
  value=oci_core_subnet.public-subnet-rdg.id
}

# Output the result
output "show-ads" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}
