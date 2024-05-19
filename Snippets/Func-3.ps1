
function Get-vTouch {

	$file = $args[0]

	if ($file -eq $args[0]) {
		throw "No filename supplied"
	}

	if (Test-Path $file) {
		Write-Output (Get-ChildItem $file).LastWriteTime
	}

}
