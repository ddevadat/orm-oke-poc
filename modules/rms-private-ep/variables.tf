variable "compartment_id" {
  type        = string
  description = "compartment ocid"
}

variable "private_endpoint_display_name" {
  default = "testResourceManagerPrivateEndpoint"
}

variable "private_endpoint_description" {
  default = "Private Endpoint to remote-exec in Private Instance"
}

variable "vcn_id" { type = string }

variable "subnet_id" { type = string }

variable "nsg_id_list" { type = list(string) }

variable "target_ip" {}