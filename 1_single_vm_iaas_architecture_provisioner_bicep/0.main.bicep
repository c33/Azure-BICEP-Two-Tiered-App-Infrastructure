//Global Variables
param p_global_location string

//VNET/Subnet Variables
param p_VNET_Name string
param p_VNET_AddressPrefixes string
param p_Subnets {
  name: string
  address_prefix: string
}[]

//VM Variables
param p_vm_Instances {
  serviceName: string
  instanceNumber: int
  vmSize: string
  adminUsername: string
  adminPassword: string
  publisher: string
  offer: string
  sku: string
  version: string
  os_disk_createOption: string
  os_disk_caching: string
  os_disk_storageAccountType: string
  data_disk_sizeGB: int
  data_disk_lun: int
  data_disk_createOption: string
}[]

//SQL Server Variables
param p_sql_server_name string
param p_sql_server_administratorLogin string
@secure()
param p_sql_server_administratorLoginPassword string
param p_sql_server_publicNetworkAccess string
param p_sql_server_version string

param p_sql_server_firewall_rule_name string
param p_sql_server_firewall_rule_endIpAddress string
param p_sql_server_firewall_rule_startIpAddress string

//SQL Database Variables
param p_sql_db_name string
param p_sql_db_sku_capacity int
param p_sql_db_sku_name string
param p_sql_db_sku_size string
param p_sql_db_sku_tier string
param p_sql_db_collation string
param p_sql_db_licenseType string
param p_sql_db_maxSizeBytes int
param p_sql_db_preferredEnclaveType string
param p_sql_db_requestedBackupStorageRedundancy string
param p_sql_db_zoneRedundant bool

//Bastion Variables
param p_bastion_pip_allocation_method string
param p_bastion_name string

module VirtualNetwork '../shared_modules/virtual_network/virtual_network.bicep' = {
  name: 'VirtualNetworkDeployment'
  params: {
    p_Subnets: p_Subnets
    p_VNET_AddressPrefixes: p_VNET_AddressPrefixes
    p_global_location: p_global_location
    p_VNET_Name: p_VNET_Name
    p_Default_NSG_ID: DefaultNSG.outputs.NSG_ID
  }
  dependsOn: [DefaultNSG]
}

module VirtualMachine '../shared_modules/virtual_machine/virtual_machine.bicep' = {
  name: 'VirtualMachineDeployment'
  params: {
    p_global_location: p_global_location
    p_vm_Instances: p_vm_Instances
    p_vm_nic_subnet: VirtualNetwork.outputs.deployed_subnets.ApplicationSubnet.id
  }
  dependsOn: [VirtualNetwork]
}

module SQL_Server '../shared_modules/sql_server/sql_server.bicep' = {
  name: 'SQLServerDeployment'
  params: {
    p_sql_server_name: p_sql_server_name
    p_global_location: p_global_location
    p_sql_server_administratorLogin: p_sql_server_administratorLogin
    p_sql_server_administratorLoginPassword: p_sql_server_administratorLoginPassword
    p_sql_server_publicNetworkAccess: p_sql_server_publicNetworkAccess
    p_sql_server_version: p_sql_server_version
    p_sql_server_firewall_rule_name: p_sql_server_firewall_rule_name
    p_sql_server_firewall_rule_startIpAddress: p_sql_server_firewall_rule_startIpAddress
    p_sql_server_firewall_rule_endIpAddress: p_sql_server_firewall_rule_endIpAddress
  }
}

module SQL_Database '../shared_modules/sql_database/sql_database.bicep' = {
  name: 'SQLDatabaseDeployment'
  params: {
    p_sql_db_sql_server_name: SQL_Server.outputs.SQLServerName
    p_global_location: p_global_location
    p_sql_db_collation: p_sql_db_collation
    p_sql_db_licenseType: p_sql_db_licenseType
    p_sql_db_maxSizeBytes: p_sql_db_maxSizeBytes
    p_sql_db_name: p_sql_db_name
    p_sql_db_preferredEnclaveType: p_sql_db_preferredEnclaveType
    p_sql_db_requestedBackupStorageRedundancy: p_sql_db_requestedBackupStorageRedundancy
    p_sql_db_sku_capacity: p_sql_db_sku_capacity
    p_sql_db_sku_name: p_sql_db_sku_name
    p_sql_db_sku_size: p_sql_db_sku_size
    p_sql_db_sku_tier: p_sql_db_sku_tier
    p_sql_db_zoneRedundant: p_sql_db_zoneRedundant
  }
  dependsOn: [SQL_Server]
}

module DefaultNSG '../shared_modules/network_security_group/network_security_group.bicep' = {
  name: 'DefaultNSGDeployment'
  params: {
    p_nsg_name: 'Default'
    p_global_location: p_global_location
  }
}

module Bastion '../shared_modules/bastion_host/bastion_host.bicep' = {
  name: 'BastionDeployment'
  params: {
    p_bastion_name: p_bastion_name
    p_bastion_pip_allocation_method: p_bastion_pip_allocation_method
    p_bastion_subnet_id: VirtualNetwork.outputs.deployed_subnets.AzureBastionSubnet.id
    p_global_location: p_global_location
  }
}
