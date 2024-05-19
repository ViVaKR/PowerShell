# (1) 원격 데스크탑 허용 확인
$result = (Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\" -Name fDenyTSConnections).fDenyTSConnections 
$resutl | &{if($result -eq 0) {"- RDP -> Allow"} Else {"- RDP -> Deny"}}

# (2) 원격 데스크탑 허용하기 ( 1 번 결과가 Deny 로 나오면...)
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0

# (3) 위 1번 커멘드로 다시 확인하여 보기 (Allow 가 나올때 까지 2번 반복)

# (4) 현재 RDP 포트 확인
(Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\" -Name PortNumber).PortNumber

# (5) 3389 포트이면? 포트 변경하기 (TCP / UDP 포트 모두 동시 변경됨)
§ Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\" -Name PortNumber -Value 9037


# (6) 방화벽 허용 설정
New-NetFirewallRule -DisplayName "Custom RDP Port (TCP-In)" -Direction Inbound -LocalPort 9037 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Custom RDP Port (UDP-In)" -Direction Inbound -LocalPort 9037 -Protocol UDP -Action Allow

# (7) 새로운 RDP 포트 확인
Get-NetTCPConnection -LocalPort 9037
Test-NetConnection -ComputerName Viv -Port 9037 -InformationLevel Quiet

# (8) 터미털 서비스 재시작
Restart-Service TermService -Force
