terraform {
  required_version = ">= 1.0"
  required_providers {
    oci = {
      source = "oracle/oci"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.2"
    }
  }
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  region       = var.region
}

provider "oci" {
  alias        = "home_region"
  tenancy_ocid = var.tenancy_ocid
  region       = lookup(data.oci_identity_regions.home_region.regions[0], "name")
}


provider "oci" {
  alias        = "current_region"
  tenancy_ocid = var.tenancy_ocid
  region       = var.region
}

provider "helm" {
  kubernetes = {
    host     = local.cluster_endpoint
    insecure = true
    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["ce", "cluster", "generate-token", "--cluster-id", local.cluster_id, "--region", local.cluster_region]
      command     = "oci"
    }
  }
}
