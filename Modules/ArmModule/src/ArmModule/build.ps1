#!/usr/bin/env pwsh
#requires -Version 7.0


# dotnet build ArmModule -c Release -o ../Output/ArmModule/
# dotnet publish -c Release -r osx-arm64 --self-contained false -o ./Output/Module

# Write-Host $PSScriptRoot

$module = 'ArmModule'
Push-Location $PSScriptRoot

dotnet build $PSScriptRoot/src/ArmModule -o $PSScriptRoot/Output/$module/bin
Copy-Item "$PSScriptRoot/$module/*" "$PSScriptRoot/Output/$module" -Recurse -Force

Import-Module "$PSScriptRoot/Output/$module/$module.psd1"
Invoke-Pester "$PSScriptRoot/Tests"
