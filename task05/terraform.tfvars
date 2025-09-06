resource_groups = {
  rg1 = {
    name     = "cmaz-65725fc3-mod5-rg-01"
    location = "West US"
    tags = {
      Creator = "azamat_kireyev@epam.com"
    }
  },
  rg2 = {
    name     = "cmaz-65725fc3-mod5-rg-02"
    location = "Central US"
    tags = {
      Creator = "azamat_kireyev@epam.com"
    }
  },
  rg3 = {
    name     = "cmaz-65725fc3-mod5-rg-03"
    location = "East US"
    tags = {
      Creator = "azamat_kireyev@epam.com"
    }
  }
}

app_service_plans = {
  asp1 = {
    name                = "cmaz-65725fc3-mod5-asp-01"
    resource_group_name = "cmaz-65725fc3-mod5-rg-01"
    location            = "West US"
    sku_tier            = "PremiumV3"
    sku_size            = "P0v3"
    worker_count        = 2
    os_type             = "Windows"
    tags = {
      Creator = "azamat_kireyev@epam.com"
    }
  },
  asp2 = {
    name                = "cmaz-65725fc3-mod5-asp-02"
    resource_group_name = "cmaz-65725fc3-mod5-rg-02"
    location            = "Central US"
    sku_tier            = "PremiumV3"
    sku_size            = "P1v3"
    worker_count        = 1
    os_type             = "Windows"
    tags = {
      Creator = "azamat_kireyev@epam.com"
    }
  }
}

web_apps = {
  app1 = {
    name                = "cmaz-65725fc3-mod5-app-01"
    location            = "West US"
    resource_group_name = "cmaz-65725fc3-mod5-rg-01"
    app_service_plan_id = "/subscriptions/e887a2a5-320e-4655-a4b3-6271b168e9df/resourceGroups/cmaz-65725fc3-mod5-rg-01/providers/Microsoft.Web/serverFarms/cmaz-65725fc3-mod5-asp-01"
    ip_restrictions = [
      {
        name     = "allow-ip"
        typ      = "ip_address"
        value    = "18.153.146.156/32"
        action   = "Allow"
        priority = 100
      },
      {
        name     = "allow-tm"
        typ      = "service_tag"
        value    = "AzureTrafficManager"
        action   = "Allow"
        priority = 200
      }
    ]
    tags = {
      Creator = "azamat_kireyev@epam.com"
    }
  },
  app2 = {
    name                = "cmaz-65725fc3-mod5-app-02"
    location            = "Central US"
    resource_group_name = "cmaz-65725fc3-mod5-rg-02"
    app_service_plan_id = "/subscriptions/e887a2a5-320e-4655-a4b3-6271b168e9df/resourceGroups/cmaz-65725fc3-mod5-rg-02/providers/Microsoft.Web/serverFarms/cmaz-65725fc3-mod5-asp-02"
    ip_restrictions = [
      {
        name     = "allow-ip"
        typ      = "ip_address"
        value    = "18.153.146.156/32"
        action   = "Allow"
        priority = 100
      },
      {
        name     = "allow-tm"
        typ      = "service_tag"
        value    = "AzureTrafficManager"
        action   = "Allow"
        priority = 200
      }
    ]
    tags = {
      Creator = "azamat_kireyev@epam.com"
    }
  }
}

traffic_manager = {
  name                = "cmaz-65725fc3-mod5-traf"
  location            = "East US"
  resource_group_name = "cmaz-65725fc3-mod5-rg-03"
  routing_method      = "Performance"
  dns_relative_name   = "cmaz-65725fc3-mod5-traf"
  dns_ttl             = 60
  tags = {
    Creator = "azamat_kireyev@epam.com"
  }
  endpoints = {
    app1 = {
      name               = "tm-endpoint-app1"
      target_resource_id = "/subscriptions/e887a2a5-320e-4655-a4b3-6271b168e9df/resourceGroups/cmaz-65725fc3-mod5-rg-01/providers/Microsoft.Web/sites/cmaz-65725fc3-mod5-app-01" # Replace <SUBSCRIPTION_ID>
      endpoint_location  = "West US"
      priority           = 1
      weight             = 100
    },
    app2 = {
      name               = "tm-endpoint-app2"
      target_resource_id = "/subscriptions/e887a2a5-320e-4655-a4b3-6271b168e9df/resourceGroups/cmaz-65725fc3-mod5-rg-02/providers/Microsoft.Web/sites/cmaz-65725fc3-mod5-app-02" # Replace <SUBSCRIPTION_ID>
      endpoint_location  = "Central US"
      priority           = 2
      weight             = 100
    }
  }
}