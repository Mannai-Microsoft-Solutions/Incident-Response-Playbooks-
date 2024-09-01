# Reports

### Send-ConnectorHealthStatus

The Logic App leverages underlying queries to provide you with an option to configure “Push notifications” to e-mail or a Microsoft Teams channel based on user defined anomaly scores as well as time since the last “Heartbeat” from Virtual Machines connected to the workspace. Below is a detailed description of how the rule and the logic app are put together

<em>The KQL query below will be added to this step in the Logic App and will execute against your workspace. You can modify the threshold values to suit your needs.</em>
```
let UpperThreshold = 3.0; // Upper Anomaly threshold score
let LowerThreshold = -3.0; // Lower anomaly threshold score
let TableIgnoreList = dynamic(['SecurityAlert', 'BehaviorAnalytics', 'SecurityBaseline', 'ProtectionStatus']); // select tables you want to EXCLUDE from the results
union withsource=TableName1 *
| make-series count() on TimeGenerated from ago(14d) to now() step 1d by TableName1
| extend (anomalies, score, baseline) = series_decompose_anomalies(count_, 1.5, 7, 'linefit', 1, 'ctukey', 0.01)
| where anomalies[-1] == 1 or anomalies[-1] == -1
| extend Score = score[-1]
| where Score >= UpperThreshold or Score <= LowerThreshold
| where TableName1 !in (TableIgnoreList)
| project TableName=TableName1, ExpectedCount=round(todouble(baseline[-1]),1), ActualCount=round(todouble(count_[-1]),1), AnomalyScore = round(todouble(score[-1]),1)
```

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FPlaybooks%2FSend-ConnectorHealthStatus%2Fazuredeploy.json)
