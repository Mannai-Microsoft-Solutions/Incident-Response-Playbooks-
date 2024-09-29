## Overview

This document outlines the details and requirements for deploying and enabling the logic app that connects Microsoft Sentinel to SMAX for ticketing services.
Integrating monitoring and service management systems into a single view centralizes tickets and incidents, regardless of the underlying cloud technology. This approach supports a multi-cloud strategy by monitoring both cloud and on-premises services, integrating them with other monitored items within the organization.

## Azure Sentinel Deployment
Mannai has designed an architecture following Microsoft's best practices for deploying and configuring Azure Sentinel-SMAX Ticketing. This document will highlight and provide an overview for the high-level deployment of the logic app.

![image](https://github.com/user-attachments/assets/ed6018fd-cfd1-4e86-a26f-e0efd5affbf5)



### Sentinel-To-SMax-Sync

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMannai-Microsoft-Solutions%2FIncident-Response-Playbooks%2Frefs%2Fheads%2Fmain%2FSMAX%2FSentinel-To-SMax-Sync%2Fazuredeploy.json)

### SMax-To-Sentinel-Sync

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMannai-Microsoft-Solutions%2FIncident-Response-Playbooks%2Frefs%2Fheads%2Fmain%2FSMAX%2FSMax-To-Sentinel-Sync%2Fazuredeploy.json)
