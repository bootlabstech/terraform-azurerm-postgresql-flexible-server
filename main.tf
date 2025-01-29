resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.psqlversion
  create_mode            = var.create_mode 
  administrator_login    = var.administrator_login
  administrator_password = random_password.password.result
  storage_mb             = var.storage_mb
  sku_name               = var.sku_name
  high_availability {
    mode                     = var.mode
    standby_availability_zone = var.standby_availability_zone
  }

  lifecycle {
    ignore_changes = [
      zone,
      high_availability.0.standby_availability_zone
    ]
  }




}

data "azurerm_key_vault" "key_vault" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
}

# Creates random password
resource "random_password" "password" {
  length      = 12
  lower       = true
  min_lower   = 6
  min_numeric = 2
  min_special = 2
  min_upper   = 2
  numeric     = true
  special     = true
  upper       = true

}

# Stores DB login password as keyvault secret
resource "azurerm_key_vault_secret" "postgressql_password" {
  name         = "${var.name}-pwd"
  value        = random_password.password.result
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [azurerm_postgresql_flexible_server.postgresql_flexible_server]
}  
# Creates  a private endpoint with private dns
resource "azurerm_private_endpoint" "endpoint" {
  name                = "${var.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.name}-connection"
    private_connection_resource_id = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
    is_manual_connection           = var.is_manual_connection
    subresource_names              = var.subresource_names

  }

  private_dns_zone_group {
    name                 = "${var.name}-dnszone"
    private_dns_zone_ids = var.private_dns_zone_ids
  }
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
  depends_on = [azurerm_postgresql_flexible_server.postgresql_flexible_server]

}