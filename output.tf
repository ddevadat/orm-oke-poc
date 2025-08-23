output "oke_cluster_name" {
  value = var.oke_cluster_name
}


output "oke_kubernetes_version" {
  value = var.oke_kubernetes_version
}

# output "oke_worker_pools" {
#   value = local.oke_worker_pools
# }

output "apiserver_private_host" {
  value = module.oke.apiserver_private_host
}


output "cluster_kubeconfig" {
  value = module.oke.cluster_kubeconfig
}


output "cluster_ca_cert" {
  value = module.oke.cluster_ca_cert
}

output "cluster_endpoints" {
  value = module.oke.cluster_endpoints
}

output "cluster_id" {
  value = module.oke.cluster_id
}
