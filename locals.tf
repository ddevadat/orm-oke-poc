locals {
  oke_home_region         = lookup(data.oci_identity_regions.home_region.regions[0], "name")
  cni_type                = (var.oke_network_type == "Flannel") ? "flannel" : "npn"
  control_plane_is_public = (var.oke_cluster_endpoint_visibility == "Private") ? false : true
  oke_worker_pool = {
    "${var.oke_node_pool_name}" = {
      create             = var.oke_enable_node_pool
      mode               = "node-pool",
      kubernetes_version = var.oke_kubernetes_version
      size               = var.oke_node_pool_size,
      shape              = lookup(var.oke_node_pool_instance_shape, "instanceShape", "VM.Standard.E4.Flex")
      ocpus              = lookup(var.oke_node_pool_instance_shape, "ocpus", 2)
      memory             = lookup(var.oke_node_pool_instance_shape, "memory", 16)
      boot_volume_size   = var.oke_node_boot_volume_size
    }
  }
  oke_worker_pools         = (var.oke_create_multiple_node_pool) ? var.oke_node_pool_properties : local.oke_worker_pool
  orm_private_ep_vcn_id    = (var.create_vcn) ? module.oke.vcn_id : var.vcn_id
  orm_private_ep_subnet_id = (var.create_vcn) ? module.oke.control_plane_subnet_id : module.oke.control_plane_subnet_id
  orm_private_ep_nsg_id    = (var.create_vcn) ? module.oke.control_plane_nsg_id : module.oke.control_plane_nsg_id
  oke_ep_private_ip        = module.oke.apiserver_private_host
  cluster_endpoint         = (var.oke_cluster_endpoint_visibility == "Private") ? "https://${module.rms-pe[0].private_ip}:6443" : module.oke.cluster_kubeconfig["clusters"][0]["cluster"]["server"]
  cluster_ca_certificate   = base64decode(module.oke.cluster_kubeconfig["clusters"][0]["cluster"]["certificate-authority-data"])
  cluster_id               = module.oke.cluster_kubeconfig["users"][0]["user"]["exec"]["args"][4]
  cluster_region           = module.oke.cluster_kubeconfig["users"][0]["user"]["exec"]["args"][6]

}