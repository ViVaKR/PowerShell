# Self Signed Certificate

New-SelfSignedCertificate -Type Custom -Subject "CN=Contoso Software, O=Contoso Corporation, C=US" -KeyUsage DigitalSignature -FriendlyName "Viv Application" -CertStoreLocation "Cert:\CurrentUser\VivApplication" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.3", "2.5.29.19={text}")

## KeyUsage : 인증서를 사용할 수 있는 항목 정의, 자체 서명시 -> DigitalSignature
## TextExtension : 
EKU(확장 키 사용): 이 확장은 인증된 공개 키를 사용할 수 있는 추가 목적을 나타냅니다. 자체 서명 인증서의 경우 이 매개 변수에는 인증서가 코드 서명에 사용되도록 나타내는 확장 문자열 "2.5.29.37={text}1.3.6.1.5.5.7.3.3"이 포함되어야 합니다.

기본 제약 조건: 이 확장은 인증서가 CA(인증 기관)인지 여부를 나타냅니다. 자체 서명 인증서의 경우 이 매개 변수에는 인증서가 CA가 아닌 최종 엔터티임을 나타내는 확장 문자열 "2.5.29.19={text}"가 포함되어야 합니다.

## PowerShell 창에서 인증서 확인
Set-Location Cert:\CurrentUser\My
Get-ChildItem | Format-Table Subject, FrendlyName, Thumbprint

## 인증서 내보내기
$password = ConvertTo-SecureString -String <Your Password> -Force -AsPlainText 
Export-PfxCertificate -cert "Cert:\CurrentUser\My\<Certificate Thumbprint>" -FilePath <FilePath>.pfx -Password $password
