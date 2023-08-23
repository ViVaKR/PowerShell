#! 경로 결합

Join-Path -Path 'RootPath' -ChildPath 'ChildPath' 
Write-Host $NULL
# 디렉토리 구분 기호가 중복되면 하나만 있도록 처리됨
Join-Path 'Root\' -ChildPath '\Child'
Write-Host $NULL

#
Join-Path "C:\Win*" "System*" -Resolve
Write-Host $null
# 여러경로의 루트를 하나의 자식경로와 결함
Join-Path -Path C:, F:, Y: -ChildPath NewFolder

Write-Host $null
# 파일 시스템 드라이브의 루트와 자식경로를 결함
Get-PSDrive -PSProvider FileSystem | ForEach-Object { $_.Root} | Join-Path -ChildPath "SubDirectory"

Join-Path -Path 'VG:' -ChildPath 'PowerShell'
