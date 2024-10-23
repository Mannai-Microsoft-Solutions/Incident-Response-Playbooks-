## Mass Download and Mass Delete Playbooks 

The Logic App leverages underlying queries to provide you with an option to configure “Push notifications” to e-mail or a Microsoft Teams channel based for mass download and delete activity in the Sharepoint using officeActivity table. Below is a detailed description of how the rule and the logic app are put together

<em>The KQL query below will be added to this step in the Logic App and will execute against your workspace. You can modify the threshold values to suit your needs.</em>

### KQL
```
let AzureRanges = externaldata(changeNumber: string, cloud: string, values: dynamic)
["https://raw.githubusercontent.com/microsoft/mstic/master/PublicFeeds/MSFTIPRanges/ServiceTags_Public.json"] with(format='multijson')
| mv-expand values
| extend Name = values.name, AddressPrefixes = values.properties.addressPrefixes
| mv-expand AddressPrefixes
| summarize by tostring(AddressPrefixes);
let MatchedIPs = OfficeActivity
| where EventSource == "SharePoint" and OfficeWorkload has_any("SharePoint", "OneDrive") and Operation has_any ('FileDownloaded', 'FileSyncDownloadedFull', 'FolderDeletedFirstStageRecycleBin', 'FileVersionsAllDeleted', 'FileDeleted')
| evaluate ipv4_lookup(AzureRanges, ClientIP, AddressPrefixes)
| project ClientIP;
let userWhiteList =dynamic([
"app@sharepoint"
]);
let threshold = 10;
OfficeActivity
| where UserId !in (userWhiteList)
| extend personalGroups = extract("(\\/+personal+\\/)", 1 , Site_Url)
//Mass File Delete Sharepoint Personal Folder == "" or  Mass File Delete Sharepoint Shared Folder != ""
| where personalGroups == ""
//FileRecycled,FileDeleted
| where EventSource == "SharePoint" and OfficeWorkload has_any("SharePoint", "OneDrive") and Operation has_any ('FileDownloaded', 'FileSyncDownloadedFull','FolderDeletedFirstStageRecycleBin', 'FileVersionsAllDeleted', 'FileDeleted')
| summarize count_distinct_OfficeObjectId=dcount(OfficeObjectId), fileslist=make_set(OfficeObjectId, 10000),workload=make_set(OfficeWorkload),siteUrl = make_set(Site_Url) by UserId,ClientIP
| where ClientIP !in (MatchedIPs)
| where count_distinct_OfficeObjectId >= threshold
| extend AccountName = tostring(split(UserId, "@")[0]), AccountUPNSuffix = tostring(split(UserId, "@")[1])
```

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/[https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Sentinel%2Fmaster%2FPlaybooks%2FSend-ConnectorHealthStatus%2Fazuredeploy.json](https://raw.githubusercontent.com/Mannai-Microsoft-Solutions/Incident-Response-Playbooks/refs/heads/main/Reports/Mass_Download_and_Mass_Delete/azuredeploy.json?token=GHSAT0AAAAAACYLKDRVT7GQPW4OTNXQXDW4ZYYRIFA))

