variable "name" {
  type        = string
  description = "The name of the PostgreSQL server."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the PostgreSQL server will be created."
}

variable "location" {
  type        = string
  description = "The Azure region where the PostgreSQL server will be deployed."
}

variable "psqlversion" {
  type        = string
  description = "The version of PostgreSQL to use (e.g., 11, 12, 13)."
}

variable "create_mode" {
  type        = string
  description = "The mode to create the PostgreSQL server (e.g., Default, Replica, PointInTimeRestore)."
}

variable "administrator_login" {
  type        = string
  description = "The administrator username for the PostgreSQL server."
}

variable "storage_mb" {
  type        = string
  description = "The maximum storage size of the PostgreSQL server in megabytes. supports to be one of [32768 65536 131072 262144 524288 1048576 2097152 4193280 4194304 8388608 16777216 33553408]"
}

variable "sku_name" {
  type        = string
  description = "The SKU tier and size for the PostgreSQL server (e.g., GP_Gen5_4)."
}

variable "keyvault_name" {
  type        = string
  description = "The name of the Key Vault used for storing secrets (e.g., admin password)."
}

variable "public_network_access_enabled" {
  type        = bool
  description = "to enable the public access of postgres db"
  default     = false
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "The ID of the subnet from which private IP addresses will be allocated for this private endpoint."
}

variable "is_manual_connection" {
  type        = bool
  description = "Specifies whether the private endpoint requires manual approval from the remote resource owner."
  default     = false
}

variable "subresource_names" {
  type        = list(string)
  description = "A list of subresource names that the private endpoint can connect to."
  default     = ["postgresqlServer"]
}

variable "private_dns_zone_ids" {
  type        = list(string)
  description = "List of private DNS zone IDs to associate with the private endpoint."
}

# variable "mode" {
#   type        = string
#   default     = "ZoneRedundant"
#   description = "Specifies the high availability mode of the PostgreSQL server (e.g., ZoneRedundant or GeoRedundant)."
# }

# variable "standby_availability_zone" {
#   type        = string
#   default     = "2"
#   description = "The availability zone used for the standby server in high availability setup."
# }

variable "zone" {
  type        = string
  default     = "1"
  description = "The primary availability zone for the PostgreSQL server."
}