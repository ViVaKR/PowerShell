# 매개변수
# 1. 필수여부 
# 2. 허용되는 값
# 3. 기본값
# 4. 도움말 메시지 제공

Param (
    [Parameter(Mandatory, HelpMessage = "Please privide a valid path")]
    $Path
)

New-Item $Path
Write-Host "File Created as path $Path"
