module "vcn"{
    source = "./vcn"
    compartment_ocid=var.compartment_ocid
    tenancy_ocid = var.tenancy_ocid
}


/* module "instance"{
    source = "./instance"
    tenancy_ocid = var.tenancy_ocid
    instance_shape=var.instance_shape
    compartment_ocid=var.compartment_ocid
    #RDG
    instance_image_ocid_linux_rdg_custom=var.instance_image_ocid_linux_rdg_custom
    #bastion win
    instance_image_ocid_win=var.instance_image_ocid_win
    #bastion linux
    instance_image_ocid=var.instance_image_ocid

    vm_ssh_public_key=var.vm_ssh_public_key
    public_subnet_id=module.vcn.public_subnet_id 
    private_subnet_id=module.vcn.private_subnet_id 
    region=var.region
} */

module "db"{
  source = "./db-system"
  compartment_ocid=var.compartment_ocid
  ssh_public_key=var.vm_ssh_public_key
  #privisiono en public subnet
  subnet_id=module.vcn.private_subnet_id
  tenancy_ocid=var.tenancy_ocid
  db_system_shape=var.db_system_shape 
} 


output "test_db_system-private_ip" {
  value=module.db.test_db_system-private_ip
}

#output "ads"{
#    value = module.vcn.show-ads
#} 

/* output "bastion-public-ip" {
  value=module.instance.bastion-public-ip
}
output "bastion-private-ip" {
  value=module.instance.bastion-private-ip
}
output "rdg-private-ip" {
  value=module.instance.rdg-private-ip
} */