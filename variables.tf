variable "name" {
    type = string

}
variable "resource_group_name" {
    type = string
  
}
variable "location" {
    type = string
  
}
variable "psqlversion" {
    type = string
  
}
variable "create_mode" {
    type = string
  
}
variable "administrator_login" {
    type = string
  
}

variable "storage_mb" {
    type = string
  
}
variable "sku_name" {
    type = string
  
}


# variable "" {
#     type = string
  
# }
variable "keyvault_name" {
    type = string
  
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint."

}

variable "is_manual_connection" {
  type        = bool
  description = "Does the Private Endpoint require Manual Approval from the remote resource owner?"
  default     = false

}
variable "subresource_names" {
  type        = list(string)
  description = " A list of subresource names which the Private Endpoint is able to connect to."
  default = [ "sqlServer" ]
}
variable "private_dns_zone_ids" {
  type        = list(string)
  description = "Specifies the list of Private DNS Zones to include within the private_dns_zone_group."
}

