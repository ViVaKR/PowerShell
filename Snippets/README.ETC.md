# Commands Memo

## 명령어 예문 (Examples)

```bash

    # New Drive : Auto Load Set -> $Profile
    Get-PSDrive -PSProvider FileSystem
    Get-PSDrive -PSProvider Registry
    Get-Command -Name New-PSDrive -Syntax
    New-PSDrive -Name vG -PSProvider FileSystem -Root "C:\<Target Folder Name>"
    New-PSDrive -Name VG -PSProvider FileSystem -Root "C:\<Target Folder Name>" | Out-Null

    # 
    Get-CimInstance -Query "Select * from Win32_BIOS"
    Get-CimInstance -ClassName Win32_BIOS
    Get-CimInstance -ClassName Win32_BIOS | Select-Object -Property SerialNumber
    Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber | Select-Object -ExpandProperty SerialNumber
    (Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber).SerialNumber

    # WMI
    Get-WmiObject Win32_BIOS | Format-List *

```

## Registry

- HKCR
- HKCU
- HKLM
- HKU



- Get-WmiObject	WMI 클래스 또는 정보의 인스턴스를 가져옵니다.
- Invoke-WmiMethod	WMI 메서드를 호출합니다.
- Register-WmiEvent	WMI 이벤트를 구독합니다.
- Remove-WmiObject	WMI 클래스 및 인스턴스를 삭제합니다.
- Set-WmiInstance	WMI 클래스의 인스턴스를 만들거나 수정합니다.
