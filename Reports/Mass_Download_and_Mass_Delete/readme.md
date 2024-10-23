## Mass Download and Mass Delete Playbooks 

The Logic App leverages underlying queries to provide you with an option to configure “Push notifications” to e-mail or a Microsoft Teams channel based for mass download and delete activity in the Sharepoint using officeActivity table. Below is a detailed description of how the rule and the logic app are put together

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

