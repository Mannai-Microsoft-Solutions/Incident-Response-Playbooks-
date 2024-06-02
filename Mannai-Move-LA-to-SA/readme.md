# Move Log Analytic logs to Storage Account

## Deploy

Description: This Playbook runs on a daily schedule and moves 89 day old logs per data type to Blob storage in hourly incremements. The result of this Playbook is a structured file explorer within a data container in Azure that allows for easy file exploration and the ability to query the data from storage within a Log Analytics workspace.

### Mannai-Move-LogAnalytics-to-Storage

## Prerequisites

You will need to authenticate a connection for Azure Monitor within the Playbook:

- Click on the Azure Monitor actions
- Chances are that the connection didn't establish, click the information icon next to the connection name to authorize the connection, it will bring up a login screen
- Log in to your account
- Confirm that the subscription, resource group, and workspace are all correct based on what you entered for the template
- Make sure that the container that you named is listed under the Azure Blob option so that the logs are routed properly when the Playbook is run
- Go to Storage account and create a container with name "logicappruntimes"

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMannai-Microsoft-Solutions%2FIncident-Response-Playbooks%2Fmain%2FMannai-Move-LA-to-SA%2Fazuredeploy.json%3Ftoken%3DGHSAT0AAAAAACLSDS3IVM6H6M4IVPUAKF4EZS4QP7Q)
