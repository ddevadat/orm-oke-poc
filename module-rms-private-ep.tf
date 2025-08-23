module "rms-pe" {
  count          = (var.oke_cluster_endpoint_visibility == "Private") ? 1 : 0
  source         = "./modules/rms-private-ep"
  compartment_id = var.oke_vcn_compartment_id
  vcn_id         = local.orm_private_ep_vcn_id
  subnet_id      = local.orm_private_ep_subnet_id
  nsg_id_list    = [local.orm_private_ep_nsg_id]
  target_ip      = local.oke_ep_private_ip
}
