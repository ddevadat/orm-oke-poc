output "oke_cluster_name" {
  value = var.oke_cluster_name
}


output "oke_kubernetes_version" {
  value = var.oke_kubernetes_version
}

output "oke_worker_pools" {
  value = local.oke_worker_pools
}