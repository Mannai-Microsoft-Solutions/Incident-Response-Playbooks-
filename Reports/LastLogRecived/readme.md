# Last log Revived Health Push Notification Solution
The Logic App leverages  underlying queries to provide you with an option to configure “Push notifications” to e-mail or a Microsoft Teams channel based on user defined Last log Revived by table as well as time since the last “Heartbeat” from Virtual Machines connected to the workspace.

**Since the Logic App is being deployed from an ARM template you will need to make connections to Azure Monitor, Office 365 and Teams before the Logic App can work in your environment.**

### The KQL query below will be added to this step in the Logic App and will execute against your workspace. You can modify the threshold values to suit your needs:

```
// Last data received, by table
let LastLogRecivedThreshold = 80m;
union withsource = _TableName *
| where TimeGenerated > ago(7d)
| summarize LastLog = max(TimeGenerated) by _TableName
| extend last_log_rec = now() - LastLog
| where last_log_rec > LastLogRecivedThreshold
| extend ['Last Record Received'] = strcat(case(last_log_rec < 2m, strcat(toint(last_log_rec / 1m), ' seconds'), last_log_rec < 2h, strcat(toint(last_log_rec / 1m), ' minutes'), last_log_rec < 2d, strcat(toint(last_log_rec / 1h), ' hours'), strcat(toint(last_log_rec / 1d), ' days')), ' ago')
| order by last_log_rec  desc
| project ['Table Name']=_TableName, ['Last Record Received'] 
```

### Execute query against workspace to detect potential VM connectivity issues

```
let Threshold= 60m;
Heartbeat
| summarize LastHeartbeat = max(TimeGenerated) by Computer
| extend TimeFromNow = now() - LastHeartbeat
| where TimeFromNow > Threshold
| extend ["TimeAgo"] = strcat(case(TimeFromNow < 2m, strcat(toint(TimeFromNow / 1m), ' seconds'), TimeFromNow < 2h, strcat(toint(TimeFromNow / 1m), ' minutes'), TimeFromNow < 2d, strcat(toint(TimeFromNow / 1h), ' hours'), strcat(toint(TimeFromNow / 1d), ' days')), ' ago')
| order by TimeFromNow desc
| project-away LastHeartbeat,TimeFromNow
```

![image](https://github.com/Mannai-Microsoft-Solutions/Incident-Response-Playbooks/assets/141730662/ec6ceeb4-2e03-4ab0-9450-40f056dfcb93)
