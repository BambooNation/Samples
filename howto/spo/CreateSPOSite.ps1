#Specify tenant admin and site URL
$URL = Read-Host -Prompt "`nPlease enter the Site URL - Ex:https://sitename.sharepoint.com" 
$Username = Read-Host -Prompt "Please enter your username" 
$Password = Read-Host -Prompt "Please enter your password" -AsSecureString 
$Title= Read-Host -Prompt "Please enter site title" 

#Add references to SharePoint client assemblies and authenticate to Office 365 site – required for CSOM
Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll" 
Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll" 
Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.WorkflowServices.dll" 

#Bind to site collection
$Context = New-Object Microsoft.SharePoint.Client.ClientContext($URL)
$Creds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Username,$Password)
$Context.Credentials = $Creds

#Create SubSite
$WCI = New-Object Microsoft.SharePoint.Client.WebCreationInformation
$WCI.WebTemplate = "STS#0"
$WCI.Description = "New Site"
$WCI.Title = $Title
$WCI.Url = $Title
$WCI.Language = "1033"
$SubWeb = $Context.Web.Webs.Add($WCI)
$Context.ExecuteQuery()