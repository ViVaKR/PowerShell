# Tutorial

## [ TLS 1.2 ]

- [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
- Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319'-Name 'SchUseStrongCrypto' -Value '1' -Type DWord
- Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord

## 스크립트 실행 방식

- 스크립트의 전체 경로를 입력합니다(예: C:\Scripts\MyScript.ps1).
- 스크립트의 상대 경로를 입력합니다(예: \Scripts\MyScript.ps1).
- 현재 디렉터리를 참조합니다(예: .\MyScript.ps1).

## [ 스크립트 실행 정책 ]

- Restricted : 스크립트를 실행할 수 없습니다.
- AllSigned : 디지털 서명된 경우에만 스크립트를 실행할 수 있습니다.
- RemoteSigned : 다운로드된 스크립트가 디지털 서명된 경우에만 실행할 수 있습니다.
- Unrestricted : 모든 스크립트를 실행할 수 있지만 다운로드된 서명되지 않은 스크립트를 실행할 때 확인 프롬프트가 표시됩니다.
- Bypass : 모든 스크립트를 확인 없이 실행합니다.

## [ 가끔 실행해야하는 경우 ]

- Powershell.exe -ExecutionPolicy ByPass

## [ 파일에 디지털 서명 추가 ]

- $cert = Get-ChildItem -Path "Cert:\CurrentUser\My" -CodeSigningCert
- Set-AuthenticodeSignature -FilePath .\VivScript.ps1 -Certificate $cert
- 스크립트를 사용하여 반복 작업을 표준화 함
- 작업을 표준화 하면 오류 위험이 줄어 듬
- 스크립트 테스트가 완료되면 오류 없이 여러번 실행할 수 있음

## [ 실행정책 ]

- Set-ExecutionPolicy
- Restricted, AllSigned, RemoteSigned, Unrestricted, Bypass
- AppLocker

## [ SqlServer ]

```bash
# NOSQLPS
Import-Module -Name SqlServer
```

- 모듈은 편리한 단위(일반적으로 단일 디렉토리에 저장) 로 그룹화되는 관련 Windows PowerShell 기능집합
- 모듈은 코드의 재사용 및 추상화를 허용하는 것
- 스크립트를 `.psm1` 파일로 저장

## [ 모듈의 구성요소 ]

- 코드 파일, PowerShell Script 또는 관리되는 Cmdlet 어셈블리
- 추가 어셈블리, 도움말 파일
- 모듈의 내용을 설명하고 모듈 처리 방법을 결정하는 파워셸 데이터 파일 (.psd1)
- Key-Value Hash Table Text file
- 이름을 모듈과 동일하게 지정하고 모듈의 루트 디렉토리에 매니페스트를 저장하여 모듈에 연결함

단일 .psm1 또는 이진 어셈블리만 포함하는 단순 모듈의 경우 모듈 매니 페스트는 선택사항이나, 코드를 구성하고 버전 관리 정보를 유지관리 하는데 유용하므로 가능한 경우 모듈 매니 페스트를 사용하는 것을 권장함.

전역 어셈블리 캐시에 어셈블리를 내보내려면 모듈 매니 페스트가 필요함.

## [ 매니페스트 만들기 : `<file-name>.psd1` ]

`New-ModuleManifest -Path F:\myModuleName.psd1 -ModuleVersion "0.0.1" -Author "Kim Bum Jun"`

- 테스트

```bash
Test-ModuleManifest myModuleName.psd1
Import-Module  .\myModuleName.psd1
```

- Get-Content
- Import-Csv
- Import-Clixml : XML 데이터 가져오기
- ConvertFrom-Json : Json 데이터 사용방법

## [ 전역 어셈블리 캐시 ]

- 공용 언어 런타임이 설치된 각 컴퓨터에는 전역 어셈블리 캐시라는 컴퓨터 수준의 코드 캐시가 있음.
- Windoes SDK 에서 제공된 전역 어셈블리 캐시 도구 (Gacutil.exe) 사용
- 전역 어셈블리 캐시(GAC)의 기본 위치 : `%windir%\Microsoft.NET\assembly`

## [ GAC ]

- Developer Command Promt 에서 (일반 명령실행창 아님)
- ngen install `해당어셈블리명`
- ngen display  `실행파일명`  
- GAC의 어셈블리 보기

```powershell
    gacutil -l
    gacutil /l
```

- GAC 어셈블리 설치

```powershell
gacutil -i <assembly name>
gacutil -i hello.dll
```

- GAC 어셈블리 제거

```powershell
gacutil -u <assembly name>
gacutil -u hello
```

<!-- Windows Installer 를 사용하여 제거 : 제어판 -> 프로그램 및 기능 
Windos Installer 는 GAC 에 설치된 어셈블리에 대한 참조 횟수를 유지 관리함, 참조횟수가 0에 도달하여 애플리케이션에서 사용되지 않음을 나타내는 경우에만 어셈블리가 GAC 에서 제거됨 -->

## [ CSC ]

```bash
csc myCode.cs
csc -out:myAssembly.exe myCode.cs
csc -out:myCodeLibrary.dll -t:library myCode.cs
```

## [ 오류 메시지 ]

- 오류가 발생하면 -> $Error 배열에 저장됨.
- 인덱스는 0 부터 생성됨 -> $Error[0]
- 다른 오류는 인덱스가 하나씩 증가.
- 스크립트가 예상대로 작동하지 않는 경우 스크립트에 추가 정보가 표시되도록 하는 것 추천
  - Write-Host
  - Write-Warning : 대체 색으로 표시
  - Write-Verbose
  - Write-Debug
  - Start-Sleep : 일시중지
  - Read-Host : 스크립트를 계속할 준비가 될 때까지 일시 중지하려는 경우

## 중단점 설정

`Set-PSBreakPoint -Script "MyScript.ps1" -Line <line-number>`
