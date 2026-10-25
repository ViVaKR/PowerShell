function New-Controller ($path, $name, [switch]$Auth) {
    $path = ($path -replace '^\.[\\/]+', '').Trim('/', '\')
    $ns = $path -replace '[\\/]+', '.'
    $name = $name -replace 'Controller$', ''
    $file = "$path/${name}Controller.cs"

    if (Test-Path $file) { Write-Warning "이미 있습니다: $file"; return }
    New-Item -ItemType Directory -Force $path | Out-Null

    $usings = "using Microsoft.AspNetCore.Mvc;"
    $attrs = ""
    if ($Auth) {
        $usings = "using Microsoft.AspNetCore.Authorization;`n$usings"
        $attrs = "[Authorize]`n"
    }

    @"
$usings

namespace $ns;

[ApiController]
[Route("[controller]")]
${attrs}public class ${name}Controller : BaseController
{
}
"@ | Set-Content $file
}

# New-Controller Buddham.Api/Controllers/Ai Ai
# New-Controller Buddham.Api/Controllers/Public Guide -Auth
