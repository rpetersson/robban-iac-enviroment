targetScope = 'subscription'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'prod-robban'
  location: 'NorwayEast'
  tags:{
    'prod': 'rg'   
  }
}

