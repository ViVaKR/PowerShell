$ipaddress = 192.168.219.200
$port = 3389
$connection = New-Object System.Net.Sockets.TcpClient($ipaddress, $port)
if ($connection.Connected) {
	Write-Output -Host "$port => Success"
}
else {
	Write-Output -Host "$port => Failed"
}
