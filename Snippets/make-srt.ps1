$filePath = "orgin.srt" # 가동안된 원본 텍스트 또는 자막 파일..
$tempPath = "temp.srt"
$target = "target.srt"

# Origin file -> Temp file
(Get-Content -Path $filePath) | Write-Output | Out-File $tempPath

# Temp file -> Remove all blank lines
(Get-Content $tempPath) | Where-Object { $_.Trim() -ne "" } | Set-Content $target

# Number Check (단락 구분용, 순번 숫자 위에 빈줄 넣기 용)
function IsNumeric ($Value) {
    return $Value -match "^[\d\.]+$"
}

$lines = Get-Content -Path $target
$outputLines = @()

foreach ($line in $lines) {
    # 달랑 숫자 만 있는 라인은 위에 빈줄 하나 넣기 
    if (IsNumeric $line) {
        $outputLines += "`r`n" + $line # [System.Environment]::NewLine
        continue
    }

    $outputLines += $line
}

# 최종 가공된 srt 파일..
$target = "target.srt"
$outputLines | Out-File -FilePath $target

# 친절한 금자 message...
Write-Host "Completed"
