#Specify tenant admin and site URL
$URL = Read-Host -Prompt "`nPlease enter the Site URL - Ex:https://sitename.sharepoint.com/subsite"
$User = Read-Host -Prompt "Please enter your User Name"
$Password = Read-Host -Prompt "Please enter your password" -AsSecureString
$ListTitle = Read-Host -Prompt "Please enter List Name"
$TemplateType = Read-Host -Prompt "Please enter Template Type"

#Add references to SharePoint client assemblies and authenticate to Office 365 site – required for CSOM
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"

#Bind to site collection
$Context = New-Object Microsoft.SharePoint.Client.ClientContext($URL)
$Creds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($User,$Password)
$Context.Credentials = $Creds

#Retrieve lists
$Lists = $Context.Web.Lists
$Context.Load($Lists)
$Context.ExecuteQuery()

##Teamplate SP list ######https://msdn.microsoft.com/en-us/library/microsoft.sharepoint.splisttemplatetype.aspx


#Create list with "custom" list template
$ListInfo = New-Object Microsoft.SharePoint.Client.ListCreationInformation
$ListInfo.Title = $ListTitle
$ListInfo.TemplateType = $TemplateType
$List = $Context.Web.Lists.Add($ListInfo)
$List.Description = $ListTitle
$List.Update()
$Context.ExecuteQuery()