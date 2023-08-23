# Commands Memo

## 명령어 예문 (Examples)

```bash
    Get-PSDrive -PSProvider FileSystem
    Get-PSDrive -PSProvider Registry
    Get-Command -Name New-PSDrive -Syntax

    # New Drive : Auto Load Set -> $Profile
    New-PSDrive -Name vG -PSProvider FileSystem -Root "C:\<Target Folder Name>"
    New-PSDrive -Name VG -PSProvider FileSystem -Root "C:\<Target Folder Name>" | Out-Null

    # 
    Get-CimInstance -Query "Select * from Win32_BIOS"
    Get-CimInstance -ClassName Win32_BIOS
    Get-CimInstance -ClassName Win32_BIOS | Select-Object -Property SerialNumber

```

## Registry

- HKCR
- HKCU
- HKLM
- HKU
