function Get-VivComputerName {
	$Env:COMPUTERNAME
}
Export-ModuleMember -Function Get-VivComputerName

<# 모듈 매니페스트
	! 모든 모듈에는 모듈 매니페스트가 있어야 함
	! 모듈 매니페스트에는 모듈 관련 메타데이터가 포함
	! 확장자 : .PSD1
	! New-ModuleManifest :  매니페스트 작성
	! RootModul 이 지정되지 않으면 모듈은 작동하지 않음
	! PowerShellGet 을 통하여 NuGet 리포지토리에 업로드 시, Author 와 Description 을 지정하는 것을 권장
	! 매니페스트가 없는 모듈의 버전은 0.0 : `Get-Module -Name VivScript`
#>

<#
	New-ModuleManifest 
	-Path `D:\Documents\PowerShell\Modules\VivModule\VivModule.psd1`
	-RootModule VivModule 
	-Author 'Kim Bum Jun' 
	-Description 'VivModule' 
	-CompanyName 'vivabm.com'
#>
