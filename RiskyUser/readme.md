# RiskyUser

## Deploy

**Deploy with incident trigger**

After deployment, you can run this playbook manually on an alert or attach it to an **analytics rule** so it will rune when an alert is created.

### Block-EntraIDUser

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FSolutions%2FMicrosoft%2520Entra%2520ID%2FPlaybooks%2FBlock-AADUser%2Fincident-trigger%2Fazuredeploy.json)

### Block-EntraIDUserOrAdmin

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FPlaybooks%2FBlock-AADUserOrAdmin%2Falert-trigger%2Fazuredeploy.json)


### Confirm-EntraIDRiskyUser

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FSolutions%2FMicrosoft%2520Entra%2520ID%2520Protection%2FPlaybooks%2FConfirm-EntraIDRiskyUser%2Fincident-trigger%2Fazuredeploy.json)

## Prerequisites

- You will need to add the managed identity that is created by the Logic App to the Security Administrator role in Azure AD.

### Dismiss-EntraIDRiskyUser

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FSolutions%2FMicrosoft%2520Entra%2520ID%2520Protection%2FPlaybooks%2FDismiss-EntraIDRiskyUser%2FDismiss-EntraIDRisky-Userincident-trigger%2Fazuredeploy.json)

## Prerequisites

- You will need to add the managed identity that is created by the Logic App to the Security Administrator role in Azure AD.

### Reset-EntraIDPassword

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FSolutions%2FMicrosoftDefenderForEndpoint%2FPlaybooks%2FRestrict-MDEIPAddress%2FRestrict-MDEIPAddress-alert-trigger%2Fazuredeploy.json)

### Revoke-EntraIDSignInSessions

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FSolutions%2FMicrosoft%2520Entra%2520ID%2FPlaybooks%2FRevoke-AADSignInSessions%2Fincident-trigger%2Fazuredeploy.json)

