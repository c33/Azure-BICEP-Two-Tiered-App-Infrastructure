param p_sql_db_sql_server_name string
param p_sql_db_name string
param p_global_location string
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

resource SQL_Database 'Microsoft.Sql/servers/databases@2023-05-01-preview' = {
  name: '${p_sql_db_sql_server_name}/${p_sql_db_name}'
  location: p_global_location
  sku: {
    capacity: p_sql_db_sku_capacity
    name: p_sql_db_sku_name
    size: p_sql_db_sku_size
    tier: p_sql_db_sku_tier
  }
  properties: {
    collation: p_sql_db_collation
    licenseType: p_sql_db_licenseType
    maxSizeBytes: p_sql_db_maxSizeBytes
    preferredEnclaveType: p_sql_db_preferredEnclaveType
    requestedBackupStorageRedundancy: p_sql_db_requestedBackupStorageRedundancy
    zoneRedundant: p_sql_db_zoneRedundant
  }
}
