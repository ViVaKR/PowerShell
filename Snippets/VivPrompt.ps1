<# 
-> Reload Profile : $ . $profile
#>

$PwshProfileFolder = (Split-Path -Parent $Profile.CurrentUserAllHosts)

#! Alias `go, ntc, vping, dnsname`
Set-Alias -Name ntc Get-NetTCPConnection
Set-Alias -Name vping Test-NetConnection
Set-Alias -Name dnsname Resolve-DnsName

#! Alias `ll`
function ll {
	param (
		$arg
	)
	$order = @(
		@{ E = 'Length'; D = ($arg -eq "l") ? $true : $false }
	)

	Get-ChildItem  |
	Sort-Object $order |
	Format-Table Mode, Attributes,
	@{N = "Creation Date"; E = { $_.CreationTime.ToShortDateString() }; Alignment = "right" },
	@{N = "Time"; E = { $_.CreationTime.ToString("HH:mm:ss") } },
	IsReadOnly,
	@{N = "LastWrite Date"; E = { $_.LastWriteTime.ToShortDateString() } ; Alignment = "right" },
	@{N = "Time"; E = { $_.LastWriteTime.ToString("HH:mm:ss") } },
	@{N = "Length(Byte)"; E = { '{0:N0}' -f ($_.Length) } }, Name -AutoSize
}

#! 파일의 해당 폴더 명 가져오기
function Get-DirOfFile ([string]$path) {
	
	$dirName = [System.IO.Path]::GetDirectoryName($path)
	Set-Location $dirName
	Get-Location
}

function Get-PipelineBeginEnd {
	begin { "Start..." }
	end { "End : The input is $input" }
}

#! Go To PowerShell Folder
function Set-Pwsh {
	param (
		[string]$location = $PwshProfileFolder
	)
	Set-Location $location
}

#! Go To 3_Workspace
function Set-Workspace {
	param (
		[string]$workspace = 'E:\3_Workspace'
	)
	Set-Location $workspace
}

function Test-VivParameter {

	param (
		[string[]]$params
	)

	foreach ($item in $params) {
		Write-Output $item
	}
}

#! Call
#+ Get-Command -Name Test-VivParameter -Syntax
#+ (Get-Command -Name Test-VivParameter).Parameters.Keys
function Test-HelloWorld {

	[CmdletBinding()]
	param (
		$ComputerName
	)

	begin {
		
	}
	
	process {
		Write-Output $ComputerName
	}
	
	end {
		
	}
}

# Call
#+ Test-VivValidation -ComputerName Viv -Messages Hello, World, Fine, Thanks, And, You
#+  Test-VivValidation -ComputerName Viv -Messages Hello, World, Fine, Thanks, And, You -Verbose
function Test-VivValidation {

	[CmdletBinding()]
	param (
		# 필수요소 
		[Parameter(Mandatory)]
		[string]$ComputerName,

		[ValidateNotNullOrEmpty()]
		[string[]]$Messages = $Env:COMPUTERNAME
	)

	process {
		Write-Output $ComputerName
		foreach ($item in $Messages) {

			# Verbose : 자세한 정보
			Write-Verbose -Message "Attemptiong to perform some action on $item"

			Write-Output $item
		}
	}
}

# 파이프라인 입력
function Test-VivPipelineInput {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory,
			ValueFromPipeline, 
			ValueFromPipelineByPropertyName)]
		[string[]]$Messages
	)
	
	begin {
		Write-Output "Start..."
	}
	
	# 파이프라인 처리, foreach loop 비슷하게 처리함
	process {
		try {
			Write-Output $Messages
			Test-WSMan -ComputerName ViV -ErrorAction Stop
		}
		catch {
			Write-Warning -Message "오류발생"
		}
	}
	
	end {
		Write-Output "Completed..."
	}
}

# 
#* Get-PSReadLineKeyHandler -Bound -Unbound
#* Get-PSReadLineOption
#* Start-Transcript -Path "C:\transcripts\transcript0.txt" -NoClobber
#* STop-Transcript
#* Get-Counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 2 -MaxSamples 3
#* Get-Counter -Counter "\Processor(_Total)\% Processor Time" -Continuous
#* Get-Counter -ListSet * | Sort-Object -Property CounterSetName | Format-Table CounterSetName, CounterSetType -AutoSize
#* Start-Job -ScriptBlock {Get-Counter -Counter "\LogicalDisk(_Total)\% Free Space" -MaxSamples 1000}
#* (Get-Counter -ListSet Memory).Paths | Where-Object { $_ -like "*Cache*" }
#* Get-WinEvent -ListLog *
#* Get-WinEvent -ListLog * -ComputerName localhost | Where-Object { $_.RecordCount }
#* (Get-WinEvent -ListLog Application).ProviderNames
#* Get-WinEvent -ListProvider *Policy*
## Log Path -> C:\Windows\System32\winevt\Logs
#todo New-Alias -Name gas -Value Get-AuthenticodeSignature
#> e.g. `gas Conf.ps1`
