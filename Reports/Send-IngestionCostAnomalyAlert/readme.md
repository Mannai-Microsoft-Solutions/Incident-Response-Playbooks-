# Ingestion Anomaly Alert Playbook

This playbook sends you an alert should there be an ingestion spike into your workspace. The playbook uses the <em>series_decompose_anomalies</em> KQL function to determine anomalous ingestion.

Microsoft Sentinel, billing is based on the amount of data ingested into Log Analytics and Azure Sentinel. 
To ensure that you have continuous visibility should the amount of billable data ingested into the platform experience an unexpected spike, we have developed this Logic App to address exactly this sort of scenario.

## Anomaly detection
This ingestion cost spike alert logic app is based on the principle of anomaly detection and as such utilizes the built-in KQL function series_decompose_anomalies(). 
It compares the baseline/expected level of ingestion over a period of time and then uses that historical pattern to determine whether to alert on a sudden increase of billable data into the workspace.

## KQL
```
let UpperThreshold = UpperAnomalyThreshold; //+3 is the suggested number and it indicates a strong anomaly though you can modify it : Outlier - Wikipedia

Usage
| where IsBillable == "true" //we are only interested in tables getting notified when a spike is detected in a billable table 
| where Quantity > ReportingQty //Allows you to report only on variations that are above a certain threshold that you deem significant enough to warrant an alert
| make-series Qty=sum(Quantity) on TimeGenerated from ago((LookBack)d) to now() step 1d by DataType //creates a time series to look at the ingestion pattern over the period defined in the LookBack variable
| extend (anomalies, score, baseline) = series_decompose_anomalies(Qty, 1.5, 7, 'linefit', 1, 'ctukey', 0.01) //takes the time series of ingested data across the days specified in the ‘LookBack’ variable and extract anomalous points with scores based on predicted values using the linear regression concept. See https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/series-decompose-anomaliesfunction for a detailed explanation of each argument. For an explanation of 'ctukey' read: Outlier - Wikipedia.

| where anomalies[-1] == 1 or anomalies[-1] == -1 //the output of series_decompose_anomalies function is three things: A ternary (as opposed to binary) series containing (+1, -1, 0) marking up/down/no anomaly respectively, the Anomaly score and the predicted value or baseline. 

| extend Score = score[-1]  //this part picks up the anomaly state from the most recent run. -1 indicates a position in the array. 

| where Score >= UpperAnomalyThreshold  //compare with strong anomaly indicator values extracted from the time series data

| extend PercentageQtyIncrease = ((round(todouble(Qty[-1]),0)-round(todouble(baseline[-1]),1))/round(todouble(Qty[-1]),0) * 100) //calculates percentage increase to present data in percent terms for easier appreciation of the anomaly
| project DataType,ExpectedQty=round(todouble(baseline[-1]),0), ActualQty=round(todouble(Qty[-1]),0),round(PercentageQtyIncrease,0)  
| order by  round(todouble(PercentageQtyIncrease),0) desc 
| where PercentageQtyIncrease > PercentIncrease //only alert if the percentage increase exceeds the threshold beyond which you specified that you wish to be notified
```

**NOTE:**  In the Ingestion Cost Anomaly App is designed to alert you, should there be an unusual spike in the billable data being ingested into the Log Analytics workspace where you have deployed Azure Sentinel. The App provides you with the flexibility to determine two thresholds around which the alerting should occur:

1. The minimum increase in the amount of data in Gigabytes around which alerting should occur. This allows you to suppress alerts triggered by increases you consider immaterial
2. The percentage increase in data. This parameter gives you additional flexibility to manage alerting thresholds by specifying what percentage increase you consider worth triggering the anomaly alert on.

## Prerequisites
1. Log analytica reader permission
2. Office 365 Service Account for sending mail notification 

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FPlaybooks%2FSend-IngestionCostAnomalyAlert%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>

## Sample Mail notification

![image](https://github.com/user-attachments/assets/a1417939-71ef-4735-b34b-c70c8901d0c6)
