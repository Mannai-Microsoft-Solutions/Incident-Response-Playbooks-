# Your tenant id (Azure Portal 🡪 Azure Active Directory 🡪 Overview)
$TenantID=""

# Install the module if it’s not already been installed
Install-Module AzureAD 
 
Connect-AzureAD -TenantId $TenantID 

#Specify the Managed Identity ID. (Azure Portal 🡪 Azure resource instance (in our example – Automation Account) 🡪 Managed Identity)
$ManagedIdentityID ="<Enter your managed identity guid here>"
$MI = Get-AzureADServicePrincipal -ObjectId $ManagedIdentityID

# Microsoft Graph App ID (DON'T CHANGE - Microsoft Graph ID is the same in all tenants)
$GraphAppId = "00000003-0000-0000-c000-000000000000"
$PermissionName = "User.ReadWrite.All" 

$GraphServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$GraphAppId'"
$AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application"}
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id