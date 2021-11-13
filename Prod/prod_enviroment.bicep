resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'Prod'
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Prod'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
}


resource networkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'miner-001'
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'Ipconfig'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetwork.id
          }
        }
      }
    ]
  }
}


resource windowsVM 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: 'miner-001'
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B4ms'
    }
    osProfile: {
      computerName: 'miner-001'
      adminUsername: 'robban'
      adminPassword: 'RobbanMiner01'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2012-R2-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: 'miner-001-disk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
        }
      ]
    }
  }
}
