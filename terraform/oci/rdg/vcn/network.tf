###########################################
###### VCN 
###########################################

resource "oci_core_vcn" "test_vcn" {
  display_name   = "vcn-test-rdg"
  cidr_block     = "10.1.0.0/16"
  compartment_id = var.compartment_ocid 
}

###########################################
###### private sunet 
###########################################

resource "oci_core_subnet" "private-subnet-rdg" {
  # Si se omite queda como regional
  #availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = "10.1.0.0/24"
  display_name        = "private-subnet-rdg"
  #dns_label           = "priv-sub-rdg"
  security_list_ids   = [oci_core_vcn.test_vcn.default_security_list_id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.test_vcn.id
  route_table_id      = oci_core_vcn.test_vcn.default_route_table_id
  dhcp_options_id     = oci_core_vcn.test_vcn.default_dhcp_options_id
  prohibit_public_ip_on_vnic = true
}

###########################################
###### public sunet 
###########################################
resource "oci_core_subnet" "public-subnet-rdg" {
  # Si se omite queda como regional
  #availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = "10.1.1.0/24"
  display_name        = "public-subnet-rdg"
  #dns_label           = "priv-sub-rdg"
  security_list_ids   = [oci_core_security_list.test_security_list.id] # [oci_core_vcn.test_vcn.default_security_list_id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.test_vcn.id
  route_table_id      = oci_core_route_table.public_subnet_route_table.id #oci_core_vcn.test_vcn.default_route_table_id
  dhcp_options_id     = oci_core_vcn.test_vcn.default_dhcp_options_id
  prohibit_public_ip_on_vnic = false
}

###########################################
###### IGW
###########################################

resource "oci_core_internet_gateway" "test_internet_gateway" {
    #Required
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.test_vcn.id

    #Optional
    enabled = true
    #defined_tags = {"Operations.CostCenter"= "42"}
    display_name = "internet-gw"
    #freeform_tags = {"Department"= "Finance"}
}


###########################################
###### ROUTE TABLE - public subnet
###########################################


resource "oci_core_route_table" "public_subnet_route_table" {
    #Required
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.test_vcn.id

    #Optional
    #defined_tags = {"Operations.CostCenter"= "42"}
    #display_name = var.route_table_display_name
    #freeform_tags = {"Department"= "Finance"}
    route_rules {
        #Required
        # "Target" en la consola OCI
        network_entity_id = oci_core_internet_gateway.test_internet_gateway.id

        #Optional
        description = "internet-gw"
        destination = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
    }
}

###########################################
###### Security List
###########################################



resource "oci_core_security_list" "test_security_list" {
    #Required
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.test_vcn.id
    display_name="sec-list-windows-bastion"

    defined_tags = {
      "lad-mcr-s.pais"="Chile"
    }
    egress_security_rules {
        #Required
        destination = "0.0.0.0/0"
        protocol = "all"

        #Optional
        description = "Agress to All"
        destination_type = "CIDR_BLOCK"
    }
    ingress_security_rules {
        #Required
        protocol = "all" #  Options are supported only for ICMP ("1"), TCP ("6"), UDP ("17"), and ICMPv6 ("58")
        source = "0.0.0.0/0"

        #Optional
        description = "Ingress solo TCP"
    }
}