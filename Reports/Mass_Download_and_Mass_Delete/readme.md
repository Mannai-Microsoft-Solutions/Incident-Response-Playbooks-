## Mass Download and Mass Delete Playbooks 

### KQL
```
let userWhiteList =dynamic([
"app@sharepoint"
]);
let threshold = 10;
OfficeActivity
| where UserId !in (userWhiteList)
| where EventSource == "SharePoint" and OfficeWorkload has_any("SharePoint", "OneDrive") and Operation has_any ("FileDownloaded", "FileSyncDownloadedFull", "FileSyncUploadedFull", "FileUploaded")
| summarize count_distinct_OfficeObjectId=dcount(OfficeObjectId), fileslist=make_set(OfficeObjectId, 10000),workload=make_set(OfficeWorkload) by UserId,ClientIP,bin(TimeGenerated, 15m)
| where count_distinct_OfficeObjectId >= threshold
| extend FileSample = iff(array_length(fileslist) == 1, tostring(fileslist[0]), strcat("SeeFilesListField","_", tostring(hash(tostring(fileslist)))))
| extend AccountName = tostring(split(UserId, "@")[0]), AccountUPNSuffix = tostring(split(UserId, "@")[1])
```

