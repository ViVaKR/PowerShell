#! Customize the prompt
function Prompt {
	$newLine = [System.Environment]::NewLine
	$date = (Get-Date).ToString("yyyy-MM-dd hh:mm:ss")
	$location = Get-Location
	"[ " + $date + " ] " + $location + $newLine + ">> "
}

. "$PSScriptRoot\VivPrompt.ps1"

#! Import Module
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

if (-not (Get-Module -ListAvailable -Name "SqlServer")) {
	Import-Module -Name SqlServer
	Write-Host "Module Imported"
}

#! Map PSDrives to other registry hives
if (!(Test-Path HKCR:)) {
	$null = New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
	$null = New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS
}
