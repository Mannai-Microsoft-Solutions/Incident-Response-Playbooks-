# EnrichEntities

## Deploy

**Deploy with incident trigger**

After deployment, you can run this playbook manually on an alert or attach it to an **analytics rule** so it will rune when an alert is created.

### Enrich-CIRCL-hashlookup

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FPlaybooks%2FEnrich-CIRCL-hashlookup%2FPlaybook%2Fazuredeploy.json)

## Prerequisites

* No authentication to hashlookup server
* Logic Apps Custom Connector CIRCL-hashlookup
* Logic App managed identity should be given Sentinel Responder role to read incident trigger and write comment/tag to incident

### Enrich-MalwareBazaar

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FPlaybooks%2FEnrich-MalwareBazaar%2FPlaybook%2Fazuredeploy.json)

## Prerequisites

* API key is not required for malwarebazaar
* Logic Apps Custom Connector for MalwareBazaar
* Logic App managed identity should be given Sentinel Responder role to read incident trigger and write comment/tag to incident


### Enrich-Intezer-Analyze-Community

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FPlaybooks%2FEnrich-Intezer-Analyze%2FPlaybook%2Fazuredeploy.json)

## Prerequisites

* Intezer Community API key. If issue with community key, reach out to Intezer and/or do free trial.
* Logic Apps Custom Connector for Intezer-Analyze-Community
* Keyvault to store Intezer API key as secret malware-intezer-api-key
  * Target keyvault parameter can be provided either through portal, either through `azuredeploy.parameters*.json` file, either shared parameters file defined through [sentinel-deployment.config](https://learn.microsoft.com/en-us/azure/sentinel/ci-cd-custom-deploy?tabs=github#scale-your-deployments-with-parameter-files)
  * Keyvault networking restrictions from LogicApps: https://aka.ms/connectors-ip-addresses
  * Logic App managed identity should be given read access, typically through [access policy](https://learn.microsoft.com/en-us/azure/key-vault/general/assign-access-policy?tabs=azure-portal)
* Logic App managed identity should be given Sentinel Responder role to read incident trigger and write comment/tag to incident
