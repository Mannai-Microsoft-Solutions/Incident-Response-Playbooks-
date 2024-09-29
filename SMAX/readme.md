## Overview

This document outlines the details and requirements for deploying and enabling the logic app that connects Microsoft Sentinel to SMAX for ticketing services.
Integrating monitoring and service management systems into a single view centralizes tickets and incidents, regardless of the underlying cloud technology. This approach supports a multi-cloud strategy by monitoring both cloud and on-premises services, integrating them with other monitored items within the organization.

## Azure Sentinel Deployment
Mannai has designed an architecture following Microsoft's best practices for deploying and configuring Azure Sentinel-SMAX Ticketing. This document will highlight and provide an overview for the high-level deployment of the logic app.

![image](https://github.com/user-attachments/assets/ed6018fd-cfd1-4e86-a26f-e0efd5affbf5)

## Permission/Role Required
1.	Microsoft Sentinel Playbook Operator/ Microsoft Sentinel Operator role (if you want to update an incident) - Role require to both playbook for connection with azure sentinel.
2.	API required roles SecurityIncident.Read.All, SecurityIncident.ReadWrite.All, Incident.Read.All, Incident.ReadWrite.All

## Powershell Script

```
SecurityIncident.Read.All, SecurityIncident.ReadWrite.All
$MIGuid=""
$MI = Get-AzureADServicePrincipal -ObjectId $MIGuid
$GraphAppId = "00000003-0000-0000-c000-000000000000"
$PermissionName = "SecurityIncident.Read.All" 
$GraphServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$GraphAppId'"
$AppRole = $GraphServicePrincipal.AppRoles | Where-Object { $_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application" }
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id

```


### Sentinel-To-SMax-Sync

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMannai-Microsoft-Solutions%2FIncident-Response-Playbooks%2Frefs%2Fheads%2Fmain%2FSMAX%2FSentinel-To-SMax-Sync%2Fazuredeploy.json)

### SMax-To-Sentinel-Sync

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMannai-Microsoft-Solutions%2FIncident-Response-Playbooks%2Frefs%2Fheads%2Fmain%2FSMAX%2FSMax-To-Sentinel-Sync%2Fazuredeploy.json)
