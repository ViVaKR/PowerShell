# PI.ps1
## 문자열 보간을 사용하기 위해서는 큰 따옴표를 사용함
## 작은 따옴표는 쓰는 그대로 출력됨
## 이스케이프 -> 역 따옴표 (`) 를 사용하면됨
## 큰 따옴표 안에서 식을 작성하기 -> "An expression $($PI + 1)"

## 전역 범위
## 스크립트 범위
## 로컬 범위

## 프로필 
#* PowerShell 이 시작도리 때 실행되는 스크립트

## $PSHOME : PowerShell 의 설치 디렉토리
## $HOME : 현재 사용자의 홈 디렉토리
## $Profile | Select-Object *
## New-Item -Path $Profile.CurrentUserCurrentHost

$PI = 3.14
Write-Host "The value of `$PI is $PI"
Write-Host "Prints An expression $PI + 1 = $($PI + 1) "

