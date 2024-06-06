$lines1 = @()

$lines2 = @()
$file2 = ""

function Is-Numeric ($Value) {
    return $Value -match "^[\d\.]+$"
}

(Get-Content filePath) | Where-Object { $_.trim() -ne "" } | Set-Content $file1
$filePath = "C:\path\to\your\file.txt"
$lines = Get-Content -Path $filePath


$outputLines = @()
$blankLineCounter = 0

foreach ($line in $lines) {
    $outputLines += $line
    $blankLineCounter++

    if ($blankLineCounter % 4 -eq 0) {
        # Insert a blank line
        $outputLines += ""
    }
}

$outputPath = "C:\path\to\output.txt"
$outputLines | Out-File -FilePath $outputPath
