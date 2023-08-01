# 주석기반 함수
function Get-MrAutoStoppedService {
	<#
	.SYNOPSIS
	 Returns a list of services that are set to start automatically, are not
	 currently running, excluding the services that are set to delayed start.
	.DESCRIPTION
	 Get-MrAutoStoppedService is a function that returns a list of services
	from
	 the specified remote computer(s) that are set to start automatically,
	are not
	 currently running, and it excludes the services that are set to start
	automatically
	 with a delayed startup.
	.PARAMETER ComputerName
	 The remote computer(s) to check the status of the services on.
	.PARAMETER Credential
	 Specifies a user account that has permission to perform this action. The
	default
	 is the current user.
	.EXAMPLE
	 Get-MrAutoStoppedService -ComputerName 'Server1', 'Server2'
	.EXAMPLE
	 'Server1', 'Server2' | Get-MrAutoStoppedService
	.EXAMPLE
	 Get-MrAutoStoppedService -ComputerName 'Server1' -Credential (GetCredential)
	.INPUTS
	 String
	.OUTPUTS
	 PSCustomObject
	.NOTES
	 Author: Mike F Robbins
	 Website: http://mikefrobbins.com
	 Twitter: @mikefrobbins
	#>
	[CmdletBinding()]
	param (
		<#
			함수에 주석 기반 도움말을 추가하는 경우 기본 제공 명령과 마찬가지로 도움말을 검색
			할 수 있습니다.
			PowerShell에서 함수를 작성하는 모든 구문은 특히 이제 막 시작하는 사용자에게는 압도
			적으로 느껴질 수 있습니다. 필자는 가끔 특정 구문이 기억나지 않을 때 별도의 모니터에
			서 ISE의 두 번째 복사본을 열고 함수의 코드를 입력하는 동안 "Cmdlet(고급 함수) -전체"
			코드 조각을 확인합니다. PowerShell ISE에서 Ctrl + J 키 조합을 사용하여 이 코드 조각
			에 액세스할 수 있습니다.
			이 장에서는 함수를 고급 함수로 전환하는 방법과 매개 변수 유효성 검사, 자세한 정보 출
			력, 파이프라인 입력, 오류 처리, 주석 기반 도움말 등 PowerShell 함수를 작성할 때 고려
			해야 할 중요한 요소 몇 가지를 포함하여 PowerShell에서 함수를 작성하는 기본 사항을
			알아보았습니다.
			1. PowerShell에서 승인된 동사 목록을 얻으려면 어떻게 하나요?
			2. PowerShell 함수를 고급 함수로 전환하려면 어떻게 하나요?
			3. WhatIf 및 Confirm 매개 변수는 언제 PowerShell 함수에 추가해야 하나요?
			4. 종료되지 않는 오류를 종료하는 오류로 전환하려면 어떻게 하나요?
			5. 주석 기반 도움말을 함수에 추가해야 하는 이유는 무엇인가요?
			about_Functions
			about_Functions_Advanced_Parameters
			about_CommonParameters
			about_Functions_CmdletBindingAttribute
			about_Functions_Advanced
			about_Try_Catch_Finally
			about_Comment_Based_Help
			비디오: 고급 함수 및 스크립트 모듈을 사용하여 PowerShell 도구 작성
		#>
	)
	#Function Body
}
	
# function <function-name> {statements}
<#
	관리자 권한으로 실행 옵션
#> 


function Get-PowerShellProcess {
	Get-Process -Name notepad
}

Get-PowerShellProcess

Get-Process notepad | Format-Table
Get-Process notepad | Format-List


