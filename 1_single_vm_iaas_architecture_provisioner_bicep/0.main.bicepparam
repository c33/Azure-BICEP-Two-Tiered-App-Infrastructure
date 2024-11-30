using './0.main.bicep'

param p_VNET_AddressPrefixes = '10.0.0.0/16'
param p_global_location = 'northeurope'
param p_VNET_Name = 'IaaS-VNET'
param p_Subnets = [
  {
    name: 'AzureBastionSubnet'
    address_prefix: '10.0.0.0/24'
  }
  {
    name: 'ApplicationSubnet'
    address_prefix: '10.0.1.0/24'
  }
]

param p_vm_Instances = [
  {
    serviceName: 'webapp1'
    instanceNumber: 001
    vmSize: 'Standard_D4s_v3'
    adminUsername: 'ProjectUser'
    adminPassword: '34syT0R3m3mb3r!'
    publisher: 'MicrosoftWindowsServer'
    offer: 'WindowsServer'
    sku: '2022-datacenter-azure-edition'
    version: 'latest'
    os_disk_createOption: 'FromImage'
    os_disk_caching: 'None'
    os_disk_storageAccountType: 'Standard_LRS'
    data_disk_sizeGB: 100
    data_disk_lun: 10
    data_disk_createOption: 'Empty'
  }
]

param p_sql_server_name = 'vmapp1sql01'
param p_sql_server_administratorLogin = 'app1dba'
param p_sql_server_administratorLoginPassword = '"St0ckC0ntrol!"'
param p_sql_server_publicNetworkAccess = 'Enabled'
param p_sql_server_version = '12.0'
param p_sql_server_firewall_rule_name = 'FromAppLayer'
param p_sql_server_firewall_rule_startIpAddress = '10.0.1.0'
param p_sql_server_firewall_rule_endIpAddress = '10.0.1.255'

param p_sql_db_name = 'app1db'
param p_sql_db_sku_capacity = 10
param p_sql_db_sku_name = 'Standard'
param p_sql_db_sku_size = 'S0'
param p_sql_db_sku_tier = 'Standard'
param p_sql_db_collation = 'Latin1_General_CI_AS'
param p_sql_db_licenseType = 'BasePrice'
param p_sql_db_maxSizeBytes = 268435456000
param p_sql_db_preferredEnclaveType = 'Default'
param p_sql_db_requestedBackupStorageRedundancy = 'Local'
param p_sql_db_zoneRedundant = false

param p_bastion_name = 'wepapp1'
param p_bastion_pip_allocation_method = 'Static'
