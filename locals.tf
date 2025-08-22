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
  oke_worker_pools = (var.oke_create_multiple_node_pool) ? var.oke_node_pool_properties : local.oke_worker_pool
}