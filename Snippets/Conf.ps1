
$work = 'D:\Document\Workspace'

function GoWin {
	Set-Location  $env:windir
}
function GoWork {
	Set-Location $work
}

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
