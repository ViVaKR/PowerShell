
using namespace System.Text
using namespace System.IO
using namespace System.Security.Cryptography


class Helper {

    [string]$Text = "Hello, World"

    CreateHash() {
        # Valid values are "SHA1", "SHA256", "SHA384", "SHA512", "MD5"
        [string]$algorithm = "SHA512"

        [byte[]]$bytes = [UnicodeEncoding]::Unicode.GetBytes($this.Text)
        [Stream]$memoryStream = [MemoryStream]::new($bytes)
        $getFileHashSplat = @{
            InputStream = $memoryStream
            Algorithm   = $algorithm
        }
        $hashFromStream = Get-FileHash @getFileHashSplat
        Write-Host $hashFromStream.Hash.ToString()
    }
}

$helper = [Helper]::new()
$helper.CreateHash()
