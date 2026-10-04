#!/usr/bin/env pwsh
#requires -Version 7.0
[CmdletBinding(SupportsShouldProcess)]
param(
  [Parameter(Mandatory, Position = 0)]
  [ValidatePattern('^[A-Za-z_][A-Za-z0-9_.]*$')]
  [string]$Module,
  [string]$Path = (Get-Location).Path
)

$root = Join-Path $Path $Module
if (Test-Path $root) { throw "이미 존재합니다: $root" }
if (-not (Get-Command dotnet -ErrorAction Ignore)) { throw "dotnet SDK를 찾을 수 없습니다." }
if (-not $PSCmdlet.ShouldProcess($root, "모듈 생성")) { return }

try {
  foreach ($d in 'src', 'Tests') {
    $null = New-Item -Path (Join-Path $root $d) -ItemType Directory -Force
  }
  $projDir = Join-Path $root 'src' $Module
  $outDir = Join-Path $root 'Output' $Module     # 배포 폴더: DLL + psd1
  $null = New-Item -Path $outDir -ItemType Directory -Force

  function Invoke-Dotnet {
    dotnet @args
    if ($LASTEXITCODE -ne 0) { throw "dotnet $($args -join ' ') 실패 (exit $LASTEXITCODE)" }
  }

  Invoke-Dotnet new classlib --name $Module --output $projDir
  Set-Content -Value '' -Path $projDir/$module.psm1
  Copy-Item $projDir/$module.psm1 $outDir -Force
  Remove-Item (Join-Path $projDir 'Class1.cs') -Force
  Invoke-Dotnet add $projDir package System.Management.Automation

  $cmdlet = "Test-$Module"
  @"
using System.Management.Automation;

namespace $Module;

[Cmdlet(VerbsDiagnostic.Test, "$Module")]
public class ${Module}Command : PSCmdlet
{
    [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
    public object? InputObject { get; set; }

    protected override void ProcessRecord() => WriteObject(InputObject);
}
"@ | Set-Content (Join-Path $projDir "${Module}Command.cs") -Encoding utf8NoBOM

  Invoke-Dotnet build $projDir -c Release -o $outDir

  New-ModuleManifest -Path (Join-Path $outDir "$Module.psd1") `
    -RootModule "$Module.dll" `
    -ModuleVersion '0.1.0' `
    -Author 'Kim Bum Jun' `
    -Description "$Module 모듈" `
    -PowerShellVersion '7.0' `
    -CompatiblePSEditions 'Core' `
    -CmdletsToExport @($cmdlet) `
    -FunctionsToExport @() -AliasesToExport @() -VariablesToExport @() `
    -Tags @('binary-module', 'dotnet', 'powershell') `
    -ProjectUri 'https://github.com/ViVaKR/PowerShell.ModuleForge' `
    -LicenseUri 'https://github.com/ViVaKR/PowerShell.ModuleForge/blob/main/LICENSE' `
    -ReleaseNotes '모듈작성기 프리뷰'

  Write-Host "모듈 $Module 작성 완료: $outDir" -ForegroundColor Green
}
catch {
  if (Test-Path $root) { Remove-Item $root -Recurse -Force }
  throw
}
