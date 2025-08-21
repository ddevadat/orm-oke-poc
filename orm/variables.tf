
variable "tenancy_ocid" {}
variable "region" { description = "Your tenancy region" }


variable "oke_cluster_compartment_id" {
  type = string
  description  = "The compartment id where you want to create OKE cluster"
}

variable "oke_vcn_compartment_id" {
  type = string
  description  = "The compartment id where you want to create OKE vcn"
}

variable "oke_cluster_name" {
  type = string
  default = "okecluster"
}

variable "oke_kubernetes_version" {
  type = string
  default = "Latest"
}

variable "oke_network_type" {
  type = string
  default = "Flannel"
}

variable "create_vcn" {
  default     = true
  description = "Whether to create a Virtual Cloud Network."
  type        = bool
}

variable "oke_show_advanced_options" {
  default     = false
  description = "Show advanced option for oke in ORM"
  type        = bool
}

variable "vcn_id" {
  default     = null
  description = "Optional ID of existing VCN. Takes priority over vcn_name filter. Ignored when `create_vcn = true`."
  type        = string
}

variable "vcn_cidrs" {
  default     = ["10.0.0.0/16"]
  description = "The list of IPv4 CIDR blocks the VCN will use."
  type        = list(string)
}

variable "oke_cluster_endpoint_visibility" {
  default     = "Private"
  description = "OKE cluster control plane visibility"

  validation {
    condition     = var.oke_cluster_endpoint_visibility == "Private" || var.oke_cluster_endpoint_visibility == "Public"
    error_message = "Sorry, but cluster endpoint visibility can only be Private or Public."
  }

}


variable "oke_create_multiple_node_pool" {
  default     = false
  description = "Whether to create more than one OKE node pool"
  type        = bool
}

variable "oke_node_pool_size" {
  description = "The number of node pools in the OKE cluster"
  type        = number
  default     = 1
}

variable "oke_node_boot_volume_size" {
  description = "The bootvolume size in GBs for node pool worker nodes. Minimum 50 Gb"
  type        = number
  default     = 50

  validation {
    condition     = var.oke_node_boot_volume_size >= 50
    error_message = "The boot volume size must be at least 50 GB."
  }
}

variable "oke_node_pool_name" {
  description = "OKE node pool name"
  type        = string
  default     = "nodepool-1"
}

variable "oke_enable_node_pool" {
  default     = true
  description = "Enable Node pool"
  type        = bool
}

variable "oke_node_pool_instance_shape" {
  type = map(any)
  default = {
    "instanceShape" = "VM.Standard.E4.Flex"
    "ocpus"         = 2
    "memory"        = 16
  }
  description = "A shape is a template that determines the number of OCPUs, amount of memory, and other resources allocated to a newly created instance for the Worker Node. Select at least 2 OCPUs and 16GB of memory if using Flex shapes"
}

variable "oke_node_pool_properties" {
  default = {
    node-pools = {
      nodepool-1 = {
        create           = true
        mode             = "node-pool",
        size             = 1,
        shape            = "VM.Standard.E4.Flex",
        ocpus            = 1,
        memory           = 16,
        boot_volume_size = 50,
      }
      nodepool-2 = {
        create           = true
        mode             = "node-pool",
        size             = 1,
        shape            = "VM.Standard.E4.Flex",
        ocpus            = 1,
        memory           = 16,
        boot_volume_size = 50,
      }
    }
  }
  description = "Default oke node properties properties"
  type        = any
}

variable "oke_ssh_private_key" {
  type = string
  description  = "The ssh private key for compute access"
}

variable "oke_ssh_public_key" {
  type = string
  description  = "The ssh public key for compute access"
}


# variable "oke_cluster_properties" {
#   default = {
#     cluster_name            = "blue"
#     cni                     = "flannel"
#     cluster_type            = "enhanced"
#     vcn_cidr                = ["10.0.0.0/16"]
#     bastion_allowed_cidrs   = ["0.0.0.0/0"]
#     control_plane_is_public = false
#     worker_pools = {
#       housekeeping = {
#         create           = true
#         mode             = "node-pool",
#         size             = 1,
#         shape            = "VM.Standard.E4.Flex",
#         ocpus            = 1,
#         memory           = 16,
#         boot_volume_size = 50,
#       }
#     }
#   }
#   description = "Default oke properties"
#   type        = any


# }

# variable "vcn_cidr" {
#   description = "vcn cidr list"
#   type        = list(string)
# }



