#! 자동변수

<# 
    $$ : 마지막 줄 마지막 토큰
    $? : 최종 명령의 True, False 반환
    $^ : 세션에서 받은 마지막 줄의 첫 번째 토큰
    $_ : $PSItem 과 동일, 파이프 라인 개체의 현재 개체 포함
    $args : 함수, 스크립트 또는 스크립트 블록에 전달되는 선언되지 않은 매개 변수에 대한 값 배열
    $ConsoleFileName : 
    $EnableExperimentalFeatures : 
    $Error : 가장 최근의 오류를 나타내는 오류 개체의 배열을 포함함. 가장최근의 오류는 배열 $Error[0]
    $Event : 처리 중인 이벤트
    $EventArgs : 
    $EventSubscriber :
    $ExecutionContext : 
    $false : 
    $foreach : 
    $HOME : 사용자 홈 디펙토리의 전체 경로, $env:USERPROFILE
    $Host : 현재 호스트 애플리케이션 개체, $Host.Version
    $input : 함수에 전달되는 모든 입력을 열거하는 열거자를 포함
    $IsCoreCLR : .NET Core 런타임에서 실행되고 있는지 여부
    $IsWindows, IsMacOS, $IsLinux
    $LASTEXITCODE : 마지막으로 실행된 네이티브 프로그램, PowerShell 스크립트의 종료 코드
    $Matches : -match, -notmatch 함께 작동.
    $MyInvocation
    $PSScriptRoot :
    $PSCommandPath : 
    $NestedPromptLevel : 
    $null : "one", $null, "three" | foreach-Object { "Hello " + $_}
    $PID : 현재 PowerShell 세션을 호스팅 하는 프로세스의 PID(프로세스 식별자)
    $PROFILE : Test-Path $PROFILE; New-Item -ItemType file -Path $PROFILE -Force
    $PSBoundParameters : 
    $PSCmdlet : 실행 중인 cmdlet 또는 고급 함수를 나타내는 개체를 포함
    $PSCommandPath : 실행중인 스크립트의 전체 경로 및 파일이름을 포함
    $PSCulture : 현재 세션의 문화권을 반영
    $PSDebugContext : 디버깅 환경에 대한 정보 포함
    $PSEdition : $PSVersionTable.PSEdition
    $PSHOME : Select-String -Pattern Variable -Path $PSHOME\*.txt
    $PSItem : $_ 과 동일, 파이프라인 개체의 현재 개체를 포함
    $PSScriptRoot : 실행 중인 스크립트의 부모 디렉토리의 전체 경로를 포함.
    $PWD : Runspace 에 대한 현재 디렉토리 위치의 전체 경로
    $PSUICulture : 운영 체제에 구성된 UI(사용자 인터페이스) 문화권의 이름을 포함. 문화권에 따라 메뉴, 메시지 등의 사용자 인터페이스 요소에 사용되는 텍스트 문자열이 결정됨.
    $PSVersionTable : PowerShell 버전에 대한 세부 정보 표시
    $Sender : 해당 이벤트를 생성한 개체, 이벤트 작업 블록 내부에서만 할당됨.
    $ShellId : 현재 셸의 식별자
    $StackTrace : 오류에 대한 스택을 추적 정보.
    $Switch : 
    $this : 클래스 자체의 인스턴스를 참조하도록 스크립트 블록에서 사용됨
    $true : 
    

#>
