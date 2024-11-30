param p_sql_server_name string
param p_global_location string
param p_sql_server_administratorLogin string
@secure()
param p_sql_server_administratorLoginPassword string
param p_sql_server_publicNetworkAccess string
param p_sql_server_version string

param p_sql_server_firewall_rule_name string
param p_sql_server_firewall_rule_endIpAddress string
param p_sql_server_firewall_rule_startIpAddress string

resource SQL_Server 'Microsoft.Sql/servers@2023-05-01-preview' = {
  name: p_sql_server_name
  location: p_global_location
  properties: {
    administratorLogin: p_sql_server_administratorLogin
    administratorLoginPassword: p_sql_server_administratorLoginPassword
    publicNetworkAccess: p_sql_server_publicNetworkAccess
    version: p_sql_server_version
  }
}

resource symbolicname 'Microsoft.Sql/servers/firewallRules@2023-05-01-preview' = {
  name: p_sql_server_firewall_rule_name
  parent: SQL_Server
  properties: {
    endIpAddress: p_sql_server_firewall_rule_endIpAddress
    startIpAddress: p_sql_server_firewall_rule_startIpAddress
  }
}

output SQLServerName string = SQL_Server.name
