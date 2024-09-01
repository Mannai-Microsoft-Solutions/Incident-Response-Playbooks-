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
//Calculation for per day cost on total GB ingestion per day. If price exceeded by per day budget it’s send notification.
let price_per_GB = price_per_GB; //price_per_GB
let how_many_days = days_in_month;  //days_in_month
let total_funding = monthly_budget; //monthly_budget
let max_per_day = toreal(total_funding) / toreal(how_many_days);  // per day budget
Usage
| where TimeGenerated > startofday(ago(1d))
| where IsBillable == true
| summarize AggregatedValue= sum(Quantity) * price_per_GB / 1024
| where AggregatedValue > max_per_day //compared against the budget value you set



//Calculation for per day cost on average(for 30 days) GB ingestion per day. Showing average GB per day and  cost per day
let rate = 3.82;                                                       //<-- Effective $ per GB rate for East US
Usage                                                                  //<-- Query the USAGE table (instead of "search *" to query everything)
| where TimeGenerated > ago(30d)                                       //<-- Check the past 30 days
| where IsBillable == true                                             //<-- Only include billable ingest volume
| summarize GB= sum(Quantity)/1024 by bin(TimeGenerated,1d)            //<-- break it up into GB/Day
| summarize AvgGBPerDay=avg(GB)                                        //<-- take the Average
| extend Cost=AvgGBPerDay * rate                                       //<-- calculate average cost
| project AvgGBPerDay=strcat(round(AvgGBPerDay,2), ' GB/Day'), AvgCostPerDay=strcat('$', round(Cost,2), ' /Day')
```
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FPlaybooks%2FSend-IngestionCostAlert%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>
