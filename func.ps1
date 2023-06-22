
# function <function-name> {statements}
<#
	관리자 권한으로 실행 옵션
#> 


function Get-PowerShellProcess {
	Get-Process -Name notepad
}

Get-PowerShellProcess
