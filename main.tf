resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.psqlversion
  create_mode            = var.create_mode 
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
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