function New-Class ($path, $name) {
    $path = ($path -replace '^\.[\\/]+', '').Trim('/', '\')   # "./", 앞뒤 "/" 제거
    $ns = $path -replace '[\\/]+', '.'                      # 연속 슬래시도 점 하나로
    $file = "$path/$name.cs"

    if (Test-Path $file) { Write-Warning "이미 있습니다: $file"; return }

    New-Item -ItemType Directory -Force $path | Out-Null
    "namespace $ns;`n`npublic class $name`n{`n}`n" | Set-Content $file
}


# New-Class Buddham.Core/Entities/Public Tangwha
