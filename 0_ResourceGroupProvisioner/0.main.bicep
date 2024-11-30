targetScope = 'subscription'

param p_RG_Name string
param p_RG_Location string
param p_RG_ManagedBy string
param p_RG_Properties object

module ResourceGroup '../shared_modules/resource_group/resource_group.bicep' = {
  name: 'ResourceGroupDeployment'
  params: {
    p_RG_Location: p_RG_Location
    p_RG_ManagedBy: p_RG_ManagedBy
    p_RG_Name: p_RG_Name
    p_RG_Properties: p_RG_Properties
  }
}
