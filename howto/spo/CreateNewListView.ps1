# Create new view for a list in SharePoint Online

 #variables that needs to be set before starting the script
 
write-host "`nEnter site URL: - EX: https://qateamqapm.sharepoint.com/sites/mynewsite" -foregroundcolor Yellow
$siteURL=Read-Host

write-host "`nEnter the Admin URL: - EX: https://qateamqapm-admin.sharepoint.com" -foregroundcolor Yellow
$adminUrl=Read-Host

write-host "`nEnter User Name:" -foregroundcolor Yellow
$userName=Read-Host

# Let the user fill in their password in the PowerShell window
$password = Read-Host "Please enter the password for $($userName)" -AsSecureString

$listName = Read-Host -Prompt "Please enter List Name"

$viewName = Read-Host -Prompt "Please enter new View Name"
$viewColumns = "Name", "Created", "Modified"
 

 
 # set credentials
 $SPOCredentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($userName, $password)
   
 # Creating client context object
 $context = New-Object Microsoft.SharePoint.Client.ClientContext($siteURL)
 $context.credentials = $SPOCredentials
 $web = $context.web
 $list = $web.lists.GetByTitle($listName)
 $context.load($list)
  
 #Creating new view using ViewCreationInformation (VCI)
 $vci = New-Object Microsoft.SharePoint.Client.ViewCreationInformation 
 $vci.Title = $viewName
 $vci.ViewTypeKind= [Microsoft.SharePoint.Client.ViewType]::None
 $vci.RowLimit=50
 $vci.SetAsDefaultView=$true 
 $vci.ViewFields=@($viewColumns)

#adding view to list
$listViews = $list.views
$context.load($listViews)
$addListView = $listViews.Add($vci)
$context.load($addListView)
$context.ExecuteQuery()

write-host "`nDone" -foregroundcolor Yellow