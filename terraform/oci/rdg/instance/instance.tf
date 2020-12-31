#######################################
##### Instancia privada 
#######################################
/* resource "oci_core_instance" "rdg-instance" {
  count               = 1
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "RDG-HOST" #"TestInstance${count.index}"
  shape               = var.instance_shape

 
  source_details {
    source_type = "image"
    source_id = var.instance_image_ocid_linux_rdg_custom[var.region]
    # Apply this to set the size of the boot volume that's created for this instance.
    # Otherwise, the default boot volume size of the image is used.
    # This should only be specified when source_type is set to "image".
    #boot_volume_size_in_gbs = "60"
  }

  create_vnic_details {
    subnet_id        = var.private_subnet_id # oci_core_subnet.private-subnet-rdg.id
    display_name     = "Primaryvnic"
    assign_public_ip = false
    #hostname_label   = "tfexampleinstance${count.index}"
  }

  # Apply the following flag only if you wish to preserve the attached boot volume upon destroying this instance
  # Setting this and destroying the instance will result in a boot volume that should be managed outside of this config.
  # When changing this value, make sure to run 'terraform apply' so that it takes effect before the resource is destroyed.
  #preserve_boot_volume = true

  metadata = {
    # "ssh_authorized_keys" - Provide one or more public SSH keys to be included in the ~/.ssh/authorized_keys
    ssh_authorized_keys = var.vm_ssh_public_key
    user_data           = base64encode(var.user_data)
  }
  
  defined_tags = {
    "lad-mcr-s.pais"="Chile"
  }

  freeform_tags = {
    "freeformkey${count.index}" = "freeformvalue${count.index}"
  }
  
  timeouts {
    create = "60m"
  }

} */

#######################################
##### Instancia publica 
#######################################
resource "oci_core_instance" "bastion-instance" {
  count               = 1
  availability_domain = data.oci_identity_availability_domain.ad.name
    compartment_id = var.compartment_ocid
  display_name        = "BASTION-HOST" #"TestInstance${count.index}"
  shape               = var.instance_shape

 
  source_details {
    source_type = "image"
    source_id = var.instance_image_ocid[var.region]
    # Apply this to set the size of the boot volume that's created for this instance.
    # Otherwise, the default boot volume size of the image is used.
    # This should only be specified when source_type is set to "image".
    #boot_volume_size_in_gbs = "60"
  }

  create_vnic_details {
    subnet_id        = var.public_subnet_id #oci_core_subnet.public-subnet-rdg.id
    display_name     = "Primaryvnic"
    assign_public_ip = true
    #hostname_label   = "tfexampleinstance${count.index}"
  }

  # Apply the following flag only if you wish to preserve the attached boot volume upon destroying this instance
  # Setting this and destroying the instance will result in a boot volume that should be managed outside of this config.
  # When changing this value, make sure to run 'terraform apply' so that it takes effect before the resource is destroyed.
  #preserve_boot_volume = true

  metadata = {
    # "ssh_authorized_keys" - Provide one or more public SSH keys to be included in the ~/.ssh/authorized_keys
    ssh_authorized_keys = var.vm_ssh_public_key
    #user_data           = base64encode(file("./userdata/bootstrap"))
  }
  
  defined_tags = {
    "lad-mcr-s.pais"="Chile"
  }

  provisioner "file" {
    source      = "/home/absalon/git-root/pocs/terraform/oci/rdg/vm-ssh-keys/ssh-key-2020-12-23.key"
    destination = "~/ssh-key-2020-12-23.key"
    connection {
      host     = oci_core_instance.bastion-instance[0].public_ip
      user  = "opc"
      private_key = file(var.ssh_private_key)
    }
  }

  timeouts {
    create = "60m"
  }

}