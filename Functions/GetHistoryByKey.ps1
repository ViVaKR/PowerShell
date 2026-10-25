function Get-HistoryByKey {
  param (
    [Parameter(Position = 0)]
    [string]$Pattern = "git",

    [Parameter(Position = 1)]
    [int]$Lines = 5
  )

  $historyPath = (Get-PSReadLineOption).HistorySavePath
  if (-not (Test-Path $historyPath)) {
    Write-Warning "히스토리 파일을 찾을 수 없습니다: $historyPath"
    return
  }

  $allLines = Get-Content $historyPath

  if ($Pattern -match '\.\*') {
    $regexPattern = $Pattern
  }
  else {
    $regexPattern = [regex]::Escape($Pattern)
  }

  # 🎯 핵심 변경점: hgrep 이나 Get-HistoryByKey 로 시작하는 자기 자신 명령어는 검색에서 제외!
  $match = $allLines | Where-Object { $_ -notmatch '^\s*(hgrep|Get-HistoryByKey)\b' } | Select-String -Pattern $regexPattern | Select-Object -Last 1

  if (-not $match) {
    Write-Host "'$Pattern' 에 대한 검색 결과가 없습니다." -ForegroundColor Yellow
    return
  }

  $targetIdx = $match.LineNumber - 1
  $startIdx = [Math]::Max(0, $targetIdx - $Lines)
  $endIdx = [Math]::Min($allLines.Count - 1, $targetIdx + $Lines)

  Write-Host "=== '$Pattern' 검색 결과 (기준 라인: 0) ===" -ForegroundColor Cyan

  for ($i = $startIdx; $i -le $endIdx; $i++) {
    $offset = $i - $targetIdx

    if ($offset -gt 0) {
      $offsetStr = "+$offset".PadLeft(4)
    }
    else {
      $offsetStr = "$offset".PadLeft(4)
    }

    if ($offset -eq 0) {
      Write-Host "[$offsetStr] > $($allLines[$i])" -ForegroundColor Green
    }
    else {
      Write-Host "[$offsetStr]   $($allLines[$i])" -ForegroundColor DarkGray
    }
  }
}

Set-Alias -Name hgrep -Value Get-HistoryByKey -Force


<#

[ 사용법 ]

hfind "kubectl get" 100                 # zsh + pwsh 에서 최근 100건
hfind "docker build .*" 50 -Source Zsh  # zsh 쪽만 (날짜도 표시)
hfind "kubectl.*ollama" 30 -Unique      # 두 쪽을 합쳐 같은 명령은 최근 1건만

---

hgrep "git commit -m" 10
hgrep "git -C ../" 20
hgrep "git.*nginx" 10
hgrep "git.*v0.0.3" 5
hgrep status

hgrep "git.*nginx" 10
#>
