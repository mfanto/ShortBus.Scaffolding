[T4Scaffolding.Scaffolder(Description = "Scaffold a ShortBus request and handler")][CmdletBinding()]
param(        
	[parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)][string]$Name,
	[string]$DefaultDirectory,
	[string]$Project,
	[string]$CodeLanguage,
	[string[]]$TemplateFolders,
	[switch]$Force = $false
)

# Setup the directory to store files in
if ([string]::IsNullOrEmpty($DefaultDirectory))
{
	$DefaultDirectory = "Mediator"
}

# Set the handler name
$HandlerName = $Name + "Handler"

# The filename extension will be added based on the template's <#@ Output Extension="..." #> directive

$RequestPath = $DefaultDirectory + "\Notifications\" + $Name  
$HandlerPath = $DefaultDirectory + "\Notifications\Handlers\" + $HandlerName

$namespace = (Get-Project $Project).Properties.Item("DefaultNamespace").Value + "." + $DefaultDirectory

Add-ProjectItemViaTemplate $RequestPath -Template ShortBus-NotificationTemplate `
	-Model @{ Namespace = $namespace; Name = $Name } `
	-SuccessMessage "Added ShortBus notification at {0}" `
	-TemplateFolders $TemplateFolders -Project $Project -CodeLanguage $CodeLanguage -Force:$Force

Add-ProjectItemViaTemplate $HandlerPath -Template ShortBus-NotificationHandlerTemplate `
	-Model @{ Namespace = $namespace; Name = $Name; HandlerName = $HandlerName } `
	-SuccessMessage "Added ShortBus notification handler at {0}" `
	-TemplateFolders $TemplateFolders -Project $Project -CodeLanguage $CodeLanguage -Force:$Force