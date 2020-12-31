#######################################
##### Instancia publica 
#######################################
resource "oci_core_instance" "bastion-instance" {
  count               = 1
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "BASTION-HOST" #"TestInstance${count.index}"
  shape               = var.instance_shape

  source_details {
    source_type = "image"
    source_id = var.instance_image_ocid_win[var.region]
    #boot_volume_size_in_gbs = "60"
  }

  create_vnic_details {
    subnet_id        = var.public_subnet_id #oci_core_subnet.public-subnet-rdg.id
    display_name     = "Primaryvnic"
    assign_public_ip = true
    #hostname_label   = "tfexampleinstance${count.index}"
  }
  
  defined_tags = {
    "lad-mcr-s.pais"="Chile"
  }

  #freeform_tags = {
  #  "freeformkey${count.index}" = "freeformvalue${count.index}"
  #}
  
  timeouts {
    create = "60m"
  }

}