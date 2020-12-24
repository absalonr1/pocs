# Configure the Oracle Cloud Infrastructure provider with an API Key

#provider "oci" {
#  alias = "personal"
#  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaahww27qgv44s5ibdur2pdshfheobg7je6rsawkqwr3wrilff7mn4q"
#  user_ocid = "ocid1.user.oc1..aaaaaaaah2bclsokfnv5k5ucqi2uqfgto2tdnydw5edibjvrnlfaofhmjjba"
#  fingerprint = "f4:c6:62:e9:d4:f6:ec:ae:0a:b2:5e:5a:6a:67:76:cf"
#  private_key_path = "/home/absalon/.oci/oci_api_key.pem"
#  region = var.region
#}

provider "oci" {
  #alias = "ladmcr"
  #config_file_profile = "./providers/ladmcr-provider.tf"
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaavl2ndgiiefoo2u4a7atlq2czcwyiu5zzb6rzwwpeyt5o2xmtaxwa"
  user_ocid = "ocid1.user.oc1..aaaaaaaag3fq6jzmx33hzxeky2rnumgalddy2nehiuiq47gispvg3icmbqwq"
  fingerprint = "46:68:55:c3:cc:2e:8b:8c:85:2e:90:22:d0:aa:fe:5d"
  private_key_path = "/home/absalon/git-root/pocs/terraform/oci/api-key-ladmcr/oracleidentitycloudservice_absalon.opazo-12-24-15-52.pem"
  region = var.region
}




# luisopazo@gmail.com
#variable "user_ocid" {
#    default ="ocid1.user.oc1..aaaaaaaah2bclsokfnv5k5ucqi2uqfgto2tdnydw5edibjvrnlfaofhmjjba"
#}
#variable "fingerprint" {
#    default ="f4:c6:62:e9:d4:f6:ec:ae:0a:b2:5e:5a:6a:67:76:cf"
#}

#variable "private_key_path" {
#    default ="/home/absalon/.oci/oci_api_key.pem"
#}

#variable "ssh_public_key" {
#    default ="oci_api_key.pem"
#}

#variable "ssh_private_key" {
#    default ="oci_api_key.pem"
#}