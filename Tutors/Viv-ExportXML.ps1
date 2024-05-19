$cred = Get-Credential
#-> ID
#-> Password
$cred | Export-Clixml .\cred.xml

# (2)

Get-Acl C:\test-acl.txt | Export-Clixml -Path .\FileACL.xml
$fileacl = Import-Clixml -Path .\test-acl.xml

$fileacl
