//Global Variables
param p_global_location string

//VM Variables
param p_vm_Instances {
  serviceName : string
  instanceNumber : int
  vmSize : string
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

param p_vm_nic_subnet string

resource vms 'Microsoft.Compute/virtualMachines@2022-03-01' = [for (i, index) in p_vm_Instances: {
  name: '${i.serviceName}-${index}-vm'
  location: p_global_location
  properties: {
    hardwareProfile: {
      vmSize: i.vmSize
    }
    osProfile: {
      computerName: '${i.serviceName}-${i.instanceNumber}'
      adminUsername: i.adminUsername
      adminPassword: i.adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: i.publisher
        offer: i.offer
        sku: i.sku
        version: i.version
      }
      osDisk: {
        createOption: i.os_disk_createOption
        caching: i.os_disk_caching
        managedDisk: {
          storageAccountType: i.os_disk_storageAccountType
        }
      }
      dataDisks: [
        {
          diskSizeGB: i.data_disk_sizeGB
          lun: i.data_disk_lun
          createOption: i.data_disk_createOption
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic[index].id
        }
      ]
    }
    }
    dependsOn: [nic]
  }]
  

resource nic 'Microsoft.Network/networkInterfaces@2024-01-01' = [for (i, index) in p_vm_Instances: {
  name: '${i.serviceName}-${index}-nic'
  location: p_global_location
  properties: {
    ipConfigurations: [
      {
        name: 'internal'
        properties: {
          privateIPAllocationMethod: 'Dynamic' 
          subnet: {
            id: p_vm_nic_subnet
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
  }
}]


