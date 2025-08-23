output "private_ip" {
  value = data.oci_resourcemanager_private_endpoint_reachable_ip.private_endpoint_reachable_ip.ip_address

}