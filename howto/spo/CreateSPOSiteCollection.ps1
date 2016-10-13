#Note: This is sample code for demonstration purpose. Use the code at your own risk.
#Specify tenant admin and site URL
write-host "`nEnter the Admin URL: - EX: https://qateamqapm-admin.sharepoint.com" -foregroundcolor Yellow
$url=Read-Host

write-host "`nEnter User Name:" -foregroundcolor Yellow
$username=Read-Host

write-host "`nEnter Password:" -foregroundcolor Yellow
$password=Read-Host

write-host "`nEnter new site collection URL: - EX: https://qateamqapm.sharepoint.com/sites/mynewsite" -foregroundcolor Yellow
$sitecolurl=Read-Host

$securePassword = ConvertTo-SecureString $Password -AsPlainText -Force 

#Add references to SharePoint client assemblies and authenticate to Office 365 site – required for CSOM

Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll" 
Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll" 
Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.WorkflowServices.dll" 

#Bind to admin site
$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userName, $(convertto-securestring $Password -asplaintext -force)

Connect-SPOService -Url $url -Credential $cred

#Create a new site collection

New-SPOSite -Url $sitecolurl -Owner $userName -StorageQuota 1000 -CompatibilityLevel 15 -LocaleID 1033 -ResourceQuota 300 -Template "STS#0" -TimeZoneId 13 -Title "My new site collection"