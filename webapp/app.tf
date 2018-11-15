resource "azurerm_app_service_plan" "theappplan" {
  name="${var.prefix}plan"
  location="${var.location}"
  resource_group_name="${azurerm_resource_group.thegroup.name}"
  sku {
    tier="Standard"
    size="S1"
  } 
}

resource "azurerm_app_service" "thewebapp" {
  name="${var.prefix}webapp"
  location="${var.location}"
  resource_group_name="${azurerm_resource_group.thegroup.name}" 
  app_service_plan_id="${azurerm_app_service_plan.theappplan.id}"

  depends_on=["azurerm_app_service_plan.theappplan"]
}

