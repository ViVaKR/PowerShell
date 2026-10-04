param(
    [string]$DLL
)
 
if (!(Test-Path $DLL)) {
    throw "File '{0}' does not exist" -f $DLL
}
 
try {
    $version =
        Get-ChildItem $DLL | Select-Object -ExpandProperty VersionInfo |
            Select-Object FileVersion | Select-Object -ExpandProperty FileVersion
 
    return $version
} catch {
    throw "Failed to get DLL file version: {0}." -f $_
}
