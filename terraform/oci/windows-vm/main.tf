module "vcn"{
    source = "./vcn"
    compartment_ocid=var.compartment_ocid
    tenancy_ocid = var.tenancy_ocid
}


module "instance"{
    source = "./instance"
    tenancy_ocid = var.tenancy_ocid
    instance_shape=var.instance_shape
    compartment_ocid=var.compartment_ocid
    instance_image_ocid=var.instance_image_ocid
    instance_image_ocid_win=var.instance_image_ocid_win
    vm_ssh_public_key=var.vm_ssh_public_key
    public_subnet_id=module.vcn.public_subnet_id # var.subnet_id 
    region=var.region
}

output "ads"{
    value = module.vcn.show-ads
} 
