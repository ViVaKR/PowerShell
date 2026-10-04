#! PowerShell Provider

Get-PSProvider | Format-Table Name, Module, PSSnapIn -AutoSize

<# 세션에 공급자를 추가한 스냅인 모듈 찾기
    Name        Module                        PSSnapIn
    ----        ------                        --------
    Registry                                  Microsoft.PowerShell.Core
    Alias                                     Microsoft.PowerShell.Core
    Environment                               Microsoft.PowerShell.Core
    FileSystem                                Microsoft.PowerShell.Core
    Function                                  Microsoft.PowerShell.Core
    Variable                                  Microsoft.PowerShell.Core
    Certificate Microsoft.PowerShell.Security 
    WSMan       Microsoft.WSMan.Management    
#>

#-> 파일 시스템 공급자의 Home 속성 경로 확인



#-> Home Path
Resolve-Path ~
(Get-PSProvider FileSystem).Home
