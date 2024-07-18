# Reports

### ReportsSend-IngestionCostAlert

This playbook will send you an alert should you exceed a budget that you define for your Azure Sentinel Workspace within a given time-frame.

1. Enter the following information

-	Subscription: Select the Subscription
-	Resource Group: Select the RG
-	Playbook Name: Enter playbook name
-	Sentinel WS Name: Enter workspace name
-	Sentinel Sub ID: Enter Subscription ID
-	Sentinel ES Resource Group: Enter Resource Group Name
-	Mail List: Enter email address of user(s) that need to get the notification
-	User Name: Enter account with permissions to create a logic app

<em>Below is the query being executed in the step above in text format which you can use for validation directly in the Log Analytics query window. Ensure to replace the variables below with actual numbers if running the query within the Log Analytics query window.</em>

```
  let price_per_GB = price_per_GB;
  let how_many_days = days_in_month;
  let total_funding = monthly_budget;
  let max_per_day = toreal(monthly_budget) / toreal(days_in_month);
  Usage
  | where TimeGenerated > startofday(ago(1d))
  | where IsBillable == true
  | summarize AggregatedValue= sum(Quantity) * price_per_GB / 1024
  | where AggregatedValue > max_per_day

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FPlaybooks%2FSend-IngestionCostAlert%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>

### Send-ConnectorHealthStatus

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FPlaybooks%2FSend-ConnectorHealthStatus%2Fazuredeploy.json)
