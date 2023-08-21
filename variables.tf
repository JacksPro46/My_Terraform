variable "rgname" {
  type = string
  description = "This is for Resource Group"
}


variable "rglocation" {
  type = string
  description = "used for rg location"
  default = "East US"
}

variable "vnet" {
  type = string
  description = "This is for Virtual Network "
}

variable "vnet_address" {
  type = string
  description = "used to assign ip address"
}

variable "subnet1" {
    type = string
    description = "used to assign subnet ip"
  
}

variable "appservice" {
  type = string
  description = "Assigned for App Service Plan"
}

variable "webappse" {
  type = string
  description = "Assigned for App Service"
}