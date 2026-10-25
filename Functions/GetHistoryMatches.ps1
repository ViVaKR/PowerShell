function Get-HistoryMatches {
  <#
  .SYNOPSIS
    히스토리 '전체'에서 패턴에 맞는 줄만 골라, 최근 N건을 오래된 순으로 보여줍니다.
    PowerShell 히스토리와 zsh 히스토리(~/.zsh_history)를 함께 찾습니다. (zsh → pwsh 순 = 오래된 → 최근)
    (앞뒤 문맥을 함께 보여주는 Get-HistoryByKey / hgrep 은 그대로 둡니다.)
  .EXAMPLE
    hfind "kubectl get" 100              # pwsh + zsh 에서 최근 100건
    hfind "kubectl get" 0                # 0 = 개수 제한 없이 전부
    hfind "kubectl.*ollama" 30 -Unique   # 같은 명령은 가장 최근 1건만
    hfind "docker build .*" 50 -Source Zsh   # zsh 히스토리에서만 (날짜도 표시)
    hfind "docker build" 50 -Raw | Set-Clipboard   # 문자열만 출력(파이프용)
  #>
  [CmdletBinding()]
  param (
    [Parameter(Position = 0)] [string]$Pattern = "git",
    [Parameter(Position = 1)] [int]$Count = 20,
    [ValidateSet('All', 'Pwsh', 'Zsh')] [string]$Source = 'All',
    [string]$ZshPath = "$HOME/.zsh_history",
    [switch]$Unique,   # 같은 명령은 가장 최근 것만
    [switch]$Raw       # 색/번호 없이 명령 문자열만 출력
  )

  # ── 도우미 ───────────────────────────────────────────
  # 다른 프로세스(PSReadLine/zsh)가 파일을 열어 둔 상태에서도 읽도록 공유 모드로 엽니다.
  function ReadAllBytesShared([string]$Path) {
    $fs = [System.IO.File]::Open($Path, 'Open', 'Read', 'ReadWrite')
    try {
      $ms = [System.IO.MemoryStream]::new()
      $fs.CopyTo($ms)
      return , $ms.ToArray()
    }
    finally { $fs.Dispose() }
  }

  # zsh 는 히스토리 파일에 0x83 바이트로 특수 바이트를 이스케이프합니다(metafy).
  # 한글 같은 비ASCII 문자가 깨지지 않도록 되돌립니다: 0x83 다음 바이트를 XOR 0x20.
  function ConvertFromZshMeta([byte[]]$Bytes) {
    $out = [System.IO.MemoryStream]::new($Bytes.Length)
    for ($i = 0; $i -lt $Bytes.Length; $i++) {
      $b = $Bytes[$i]
      if ($b -eq 0x83 -and ($i + 1) -lt $Bytes.Length) { $i++; $b = $Bytes[$i] -bxor 0x20 }
      $out.WriteByte($b)
    }
    return [System.Text.Encoding]::UTF8.GetString($out.ToArray())
  }

  function ReadPwshEntries([string]$Path) {
    $list = [System.Collections.Generic.List[object]]::new()
    $sr = [System.IO.StreamReader]::new([System.IO.MemoryStream]::new((ReadAllBytesShared $Path)))
    $n = 0
    while ($null -ne ($line = $sr.ReadLine())) {
      $n++
      $list.Add([pscustomobject]@{ Src = 'p'; Line = $n; Time = $null; Text = $line })
    }
    return , $list
  }

  function ReadZshEntries([string]$Path) {
    $list = [System.Collections.Generic.List[object]]::new()
    $text = ConvertFromZshMeta (ReadAllBytesShared $Path)
    $n = 0
    $cur = ''
    foreach ($raw in ($text -split "`r?`n")) {
      # 줄 끝이 \ 이면 다음 줄까지 한 명령(멀티라인)
      if ($raw.EndsWith('\')) { $cur += $raw.Substring(0, $raw.Length - 1) + ' ⏎ '; continue }
      $cur += $raw
      if ($cur.Length -eq 0) { continue }
      $n++
      $time = $null
      $cmd = $cur
      # EXTENDED_HISTORY 형식:  : 1697000000:0;명령
      if ($cur -match '^: (\d+):\d+;(.*)$') {
        $time = [DateTimeOffset]::FromUnixTimeSeconds([long]$Matches[1]).LocalDateTime
        $cmd = $Matches[2]
      }
      $list.Add([pscustomobject]@{ Src = 'z'; Line = $n; Time = $time; Text = $cmd })
      $cur = ''
    }
    return , $list
  }
  # ─────────────────────────────────────────────────────

  # hgrep 과 같은 규칙: '.*' 가 들어 있으면 정규식, 아니면 문자 그대로
  $regexPattern = if ($Pattern -match '\.\*') { $Pattern } else { [regex]::Escape($Pattern) }
  $re   = [regex]::new($regexPattern, 'IgnoreCase')
  $self = [regex]::new('^\s*(hgrep|hfind|Get-HistoryByKey|Get-HistoryMatches)\b', 'IgnoreCase')

  $all = [System.Collections.Generic.List[object]]::new()

  if ($Source -in 'All', 'Zsh') {
    if (Test-Path -LiteralPath $ZshPath) { $all.AddRange([object[]](ReadZshEntries $ZshPath)) }
    elseif ($Source -eq 'Zsh') { Write-Warning "zsh 히스토리 파일을 찾을 수 없습니다: $ZshPath"; return }
  }
  if ($Source -in 'All', 'Pwsh') {
    $pwshPath = (Get-PSReadLineOption).HistorySavePath
    if (Test-Path -LiteralPath $pwshPath) { $all.AddRange([object[]](ReadPwshEntries $pwshPath)) }
    elseif ($Source -eq 'Pwsh') { Write-Warning "히스토리 파일을 찾을 수 없습니다: $pwshPath"; return }
  }

  $hits = [System.Collections.Generic.List[object]]::new()
  foreach ($e in $all) {
    if ($self.IsMatch($e.Text) -or -not $re.IsMatch($e.Text)) { continue }
    $hits.Add($e)
  }

  if ($hits.Count -eq 0) {
    Write-Host "'$Pattern' 에 대한 검색 결과가 없습니다." -ForegroundColor Yellow
    return
  }

  if ($Unique) {
    $seen = [System.Collections.Generic.HashSet[string]]::new()
    $dedup = [System.Collections.Generic.List[object]]::new()
    for ($i = $hits.Count - 1; $i -ge 0; $i--) {
      if ($seen.Add($hits[$i].Text.Trim())) { $dedup.Add($hits[$i]) }
    }
    $dedup.Reverse()
    $hits = $dedup
  }

  $total = $hits.Count
  $skip  = if ($Count -gt 0) { [Math]::Max(0, $total - $Count) } else { 0 }
  $view  = $hits | Select-Object -Skip $skip

  if ($Raw) { return $view.Text }

  Write-Host "=== '$Pattern' 전체 $total 건 중 최근 $($total - $skip) 건  [z]=zsh [p]=pwsh, 번호=각 히스토리 파일 기준 ===" -ForegroundColor Cyan
  foreach ($h in $view) {
    $date = if ($h.Time) { $h.Time.ToString('yyyy-MM-dd') } else { '' }
    Write-Host ("[{0}] {1,7} {2,-10}  " -f $h.Src, $h.Line, $date) -NoNewline -ForegroundColor DarkGray
    $pos = 0
    foreach ($m in $re.Matches($h.Text)) {
      if ($m.Index -gt $pos) { Write-Host $h.Text.Substring($pos, $m.Index - $pos) -NoNewline }
      Write-Host $m.Value -NoNewline -ForegroundColor Green
      $pos = $m.Index + $m.Length
    }
    Write-Host $h.Text.Substring($pos)
  }
}

Set-Alias -Name hfind -Value Get-HistoryMatches -Force
