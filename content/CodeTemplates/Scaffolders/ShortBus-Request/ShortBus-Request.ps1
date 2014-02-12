[T4Scaffolding.Scaffolder(Description = "Scaffold a ShortBus request and handler")][CmdletBinding()]
param(        
	[parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)][string]$Name,
	[parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)][string]$ReturnType,
	[string]$DefaultDirectory,
	[string]$Project,
	[string]$CodeLanguage,
	[string[]]$TemplateFolders,
	[switch]$Force = $false
)

# Find the return type
$foundModelType = Get-ProjectType $ReturnType -Project $Project

if (!$foundModelType) 
{ 
	Write-Host "Cannot find the model type"
	return
}

# Setup the directory to store files in
if ([string]::IsNullOrEmpty($DefaultDirectory))
{
	$DefaultDirectory = "Mediator"
}

# Set the handler name
$HandlerName = $Name + "Handler"

# The filename extension will be added based on the template's <#@ Output Extension="..." #> directive

$RequestPath = $DefaultDirectory + "\Requests\" + $Name  
$HandlerPath = $DefaultDirectory + "\Requests\Handlers\" + $HandlerName

$namespace = (Get-Project $Project).Properties.Item("DefaultNamespace").Value + "." + $DefaultDirectory
$ModelNamespace = [T4Scaffolding.Namespaces]::GetNamespace($foundModelType.FullName)

Add-ProjectItemViaTemplate $RequestPath -Template ShortBus-RequestTemplate `
	-Model @{ Namespace = $namespace; Name = $Name; ReturnType = $ReturnType; ModelNamespace = $ModelNamespace } `
	-SuccessMessage "Added ShortBus request at {0}" `
	-TemplateFolders $TemplateFolders -Project $Project -CodeLanguage $CodeLanguage -Force:$Force

Add-ProjectItemViaTemplate $HandlerPath -Template ShortBus-RequestHandlerTemplate `
	-Model @{ Namespace = $namespace; Name = $Name; ReturnType = $ReturnType; HandlerName = $HandlerName; ModelNamespace = $ModelNamespace } `
	-SuccessMessage "Added ShortBus request handler at {0}" `
	-TemplateFolders $TemplateFolders -Project $Project -CodeLanguage $CodeLanguage -Force:$Force