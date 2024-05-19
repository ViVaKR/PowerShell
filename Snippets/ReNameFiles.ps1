
#! Rename Files Recursively (파일이름 변경하기 서브 디렉토리 포함)

if($args.Length -lt 3) 
{
    Write-Host "매개변수의 갯수(파일경로, 원래이름, 변경할 이름)가 맞지 않습니다."
    Write-Host "매개변수는 3개를 순서에 맞게 정확히 넣어 주세요..."
    Write-Host "e.g. => .\ReNameFiles.ps1 'F:\Temp\ReNameFolder' 'kk ' 'vv'"
    return
}

Write-Host "이름변경 시작"
[string]$path = $args[0]
Write-Host ".."
[string]$org = $args[1]
Write-Host "..."
[string]$rename = $args[2]
Write-Host "..."
Get-ChildItem -Path $path -File -Recurse | Rename-Item -NewName { $_.Name.replace($org, $rename) }
Write-Host "이름변경 완료!"

#! 사용법, PowerShell 실행후.. ReNameFiles.ps1 파일이 있는 곳으로 이동..
#-> .\ReNameFiles.ps1  '변경할 파일이 있는 경로' '변경대상 문자' '변경될 문자'
