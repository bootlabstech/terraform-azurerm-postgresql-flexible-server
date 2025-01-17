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
  delegated_subnet_id    = var.delegated_subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.dnszone.id

  depends_on = [ azurerm_private_dns_zone_virtual_network_link.link ]


}
resource "azurerm_private_dns_zone" "dnszone" {
  name                = "${var.name}.private.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  name                  = "${var.name}-link"
  private_dns_zone_name = azurerm_private_dns_zone.dnszone.name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource_group_name
  depends_on = [ azurerm_private_dns_zone.dnszone ]
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