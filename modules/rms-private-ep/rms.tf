resource "oci_resourcemanager_private_endpoint" "rms_pe" {
  compartment_id = var.compartment_id
  display_name   = var.private_endpoint_display_name
  description    = var.private_endpoint_description
  vcn_id         = var.vcn_id
  subnet_id      = var.subnet_id
  nsg_id_list    = length(var.nsg_id_list) == 0 ? [] : var.nsg_id_list

}

data "oci_resourcemanager_private_endpoint_reachable_ip" "private_endpoint_reachable_ip" {
  private_endpoint_id = oci_resourcemanager_private_endpoint.rms_pe.id
  private_ip          = var.target_ip
}
