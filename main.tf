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


}