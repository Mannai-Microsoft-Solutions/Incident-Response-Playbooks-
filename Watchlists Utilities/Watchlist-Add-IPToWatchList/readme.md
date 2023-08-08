#  Add-IPToWatchist

This playbook will add a IP entity to a new or existing watchlist.
 
## Logical flow to use this playbook

	1. The analyst finished investigating an incident and one of its findings is a suspicious IP entity.
	2. The analyst wants to enter this entity into a watchlist (can be from block list type or allowed list).
	3. This playbook will run as a manual trigger from the full incident blade or the investigation graph blade, or automatically, and will add host to the selected watchlist.

# Prerequisites

None.

# Quick Deployment
After deployment, attach this playbook to an **automation rule** so it runs when the incident is created.

**Deploy with alert trigger**

After deployment, you can run this playbook manually on an alert or attach it to an **analytics rule** so it will rune when an alert is created.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FSolutions%2FWatchlists%20Utilities%2FPlaybooks%2FWatchlist-Add-IPToWatchList%2Falert-trigger%2Fazuredeploy.json)

# Post-deployment
1. Assign Microsoft Sentinel Contributor role to the Playbook's Managed Identity
