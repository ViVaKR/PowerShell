# ⏱️ [상단] 닷넷 정밀 스톱워치 기동!
$sw = [System.Diagnostics.Stopwatch]::StartNew()

# =================================================================
# ⚔️ 10만 발 일제 사격 구역!
# =================================================================
1..100000 | ForEach-Object -Parallel {
  # 맥OS 터미널(화면)이 10만 줄의 글자를 스크롤해서 그리느라(화면 렌더링 병목 & I/O 락) 터미널이 헉헉대며 멈칫거림. (무의미 )
  # Write-Host "사격 번호: $_ (스레드 ID: $([System.Threading.Thread]::CurrentThread.ManagedThreadId))"

  # 화면 출력 없이 10만 번의 순수 병렬 연산만 수행!
  $null = [Math]::Sqrt($_) * [Math]::Sin($_)
} -ThrottleLimit 10

# ⏱️ [하단] 스톱워치 정지 및 측정 완료!
$sw.Stop()

# 🎯 품격 있는 결과 보고
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "🎯 총 사격 소요 시간 : $($sw.Elapsed.TotalSeconds.ToString('N2')) 초" -ForegroundColor Yellow
Write-Host "⚡ 밀리초(ms) 단위  : $($sw.ElapsedMilliseconds.ToString('N0')) ms" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
