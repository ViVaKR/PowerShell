
using namespace System.Text
using namespace System.IO
using namespace System.Security.Cryptography

[string]$string = "Hello, World!"

# Valid values are "SHA1", "SHA256", "SHA384", "SHA512", "MD5"
[string]$algorithm = "SHA256"

[byte[]]$stringBytes = [UnicodeEncoding]::Unicode.GetBytes($string)
[Stream]$memoryStream = [MemoryStream]::new($stringBytes)

$getFileHashSplat = @{
    InputStream = $memoryStream
    Algorithm   = $algorithm
}

$hashFromStream = Get-FileHash @getFileHashSplat

Write-Host $hashFromStream.Hash.ToString()
