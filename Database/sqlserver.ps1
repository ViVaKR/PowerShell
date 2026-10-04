function Execute-SqlCmd {
    param (
        [string]$IpAddress
    )
    $Password = [System.Environment]::GetEnvironmentVariable("SA_PASSWORD", `
            [System.EnvironmentVariableTarget]::User)
    sqlcmd -S $IpAddress -U SA -d master -P $Password -y 30 -Y 30
}


# Set / Get, Global Variable
# Set --> [System.Environment]::SetEnvironmentVariable("SA_PASSWORD", "Pass@word!", [System.EnvironmentVariableTarget]::User)
# Get --> $Password = [System.Environment]::GetEnvironmentVariable("SA_PASSWORD", [System.EnvironmentVariableTarget]::User)
# 명령어는 사용자 환경 변수로 "SA_PASSWORD"를 설정합니다. 이 설정은 레지스트리의 HKEY_CURRENT_USER\Environment 경로에 저장됩니다.
# Read Reg --> Get-ItemProperty -Path "HKCU:\Environment"
