function Update-SystemPath {
    param (
        [string]$pathString
    )

    # 기존 시스템 환경변수(Path) 불러오기
    $currentPaths = [System.Environment]::GetEnvironmentVariable("Path", "Machine") -split ';'

    # 새로운 경로를 ; 기준으로 분리
    $newPaths = $pathString -split ';'

    # 기존 경로 + 새 경로 병합 후 중복 제거
    $updatedPaths = ($currentPaths + $newPaths) | Where-Object { $_ -and $_.Trim() -ne "" } | ForEach-Object { $_.TrimEnd("\").ToLower() } | Select-Object -Unique

    # 시스템 환경변수 업데이트 (관리자 권한 필요)
    [System.Environment]::SetEnvironmentVariable("Path", ($updatedPaths -join ';'), "Machine")

    # 확인용 출력
    Write-Output "시스템 환경변수가 성공적으로 업데이트되었습니다."
    Write-Output "새로운 Path 값:"
    $updatedPaths -join "`n"
}

# 의도한 환경설정 내용 (이중 세미콜론 제거함)
$myPathString = "%INTEL_DEV_REDIST%redist\intel64_win\mpirt;%INTEL_DEV_REDIST%redist\intel64_win\compiler;C:\SIMULIA\Commands;C:\Program Files\Microsoft MPI\Bin\;C:\Program Files\Semeru\jdk-17.0.14.7-openj9\bin;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\dotnet\;C:\Program Files\Bandizip\;C:\Program Files (x86)\Intel\oneAPI\compiler\2025.0\env;C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build;C:\Program Files\NVIDIA Corporation\NVIDIA app\NvDLISR;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common"

Update-SystemPath -pathString $myPathString