#!/usr/bin/env pwsh

# =====================================================================
# 🐮 백우(Baek-Woo) 총제독 전용 T-1000 PowerShell Core K8s 통합 지휘 무기고
# =====================================================================

# ---------------------------------------------------------------------
# 0. 네임스페이스 컨텍스트 설정 & 스위처 (Core Engine)
# ---------------------------------------------------------------------
$global:CURRENT_NS = "buddham"

# 네임스페이스 자동완성을 위한 동적 목록
$script:NamespaceList = @(
  'buddham', 'dhamma', 'kimbumjun', 'vivabm',
  'writer', 'text', 'vivakr', 'commando1', 'commando2'
)

function Set-K8sNamespace {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ArgumentCompleter({
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
        $script:NamespaceList | Where-Object { $_ -like "$wordToComplete*" }
      })]
    [string]$Namespace
  )
  $global:CURRENT_NS = $Namespace
  Write-Host "🎯 현재 타겟 네임스페이스가 [$global:CURRENT_NS] (으)로 변경되었습니다!" -ForegroundColor Green
}
Set-Alias -Name kns -Value Set-K8sNamespace

function Get-K8sCurrentNamespace {
  Write-Host "📍 현재 설정된 네임스페이스: [$global:CURRENT_NS]" -ForegroundColor Cyan
}
Set-Alias -Name kns-get -Value Get-K8sCurrentNamespace


# Helper: 네임스페이스 파라미터 미지정 시 전역 변수 적용
function Get-TargetNs ([string]$Ns) {
  if ([string]::IsNullOrWhiteSpace($Ns)) { return $global:CURRENT_NS }
  return $Ns
}


# ---------------------------------------------------------------------
# 1. 파드 및 리소스 상태 확인 (Pod & Resource Status)
# ---------------------------------------------------------------------
function Get-K8sPods {
  param([string]$Ns = $global:CURRENT_NS)
  kubectl get pods -n (Get-TargetNs $Ns)
}
Set-Alias -Name kgp -Value Get-K8sPods

function Get-K8sPodsRunning {
  param([string]$Ns = $global:CURRENT_NS)
  kubectl get pods -n (Get-TargetNs $Ns) | Select-String "Running"
}
Set-Alias -Name kgpr -Value Get-K8sPodsRunning

function Get-K8sAll {
  param([string]$Ns = $global:CURRENT_NS)
  kubectl get all -n (Get-TargetNs $Ns)
}
Set-Alias -Name kga -Value Get-K8sAll

function Get-K8sPodsWide {
  param([string]$Ns = $global:CURRENT_NS)
  kubectl get pods -n (Get-TargetNs $Ns) -o wide
}
Set-Alias -Name kgpw -Value Get-K8sPodsWide

# PowerShell 방식의 실시간 watch (while 루프)
function Watch-K8sPods {
  param(
    [string]$Ns = $global:CURRENT_NS,
    [int]$IntervalSec = 2
  )
  $targetNs = Get-TargetNs $Ns
  while ($true) {
    Clear-Host
    Write-Host "👀 [Watch Mode] Target Namespace: [$targetNs] (Ctrl+C 로 종료)" -ForegroundColor Yellow
    kubectl get pods -n $targetNs
    Start-Sleep -Seconds $IntervalSec
  }
}
Set-Alias -Name kgpwch -Value Watch-K8sPods

function Describe-K8sApiPod {
  param(
    [string]$AppName = "buddham-api",
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl describe pod -l "app=$AppName" -n (Get-TargetNs $Ns)
}
Set-Alias -Name kdp -Value Describe-K8sApiPod

function Get-K8sEvents {
  param([string]$Ns = $global:CURRENT_NS)
  kubectl get events -n (Get-TargetNs $Ns) --sort-by='.lastTimestamp'
}
Set-Alias -Name kgev -Value Get-K8sEvents


# ---------------------------------------------------------------------
# 2. 파드 내부 접근 및 디버그 (Exec & Debug)
# ---------------------------------------------------------------------
function Enter-K8sDeployShell {
  param(
    [string]$DeployName = "buddham-api-deploy",
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl exec -it "deployment/$DeployName" -n (Get-TargetNs $Ns) -- bash
}
Set-Alias -Name kexec -Value Enter-K8sDeployShell

function Get-K8sEnv {
  param(
    [string]$DeployName = "buddham-api-deploy",
    [string]$Filter = "ConnectionStrings",
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl exec -it "deployment/$DeployName" -n (Get-TargetNs $Ns) -- env | Select-String $Filter
}
Set-Alias -Name kenv -Value Get-K8sEnv

function Get-K8sOllamaEnv {
  param(
    [string]$AppName = "buddham-api",
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl describe pod -l "app=$AppName" -n (Get-TargetNs $Ns) | Select-String -Pattern "Ollama" -Context 0, 5
}
Set-Alias -Name kollama -Value Get-K8sOllamaEnv

function Start-K8sDebugPod {
  param([string]$Ns = $global:CURRENT_NS)
  kubectl run debug --image=nicolaka/netshoot --rm -it --restart=Never -n (Get-TargetNs $Ns) -- bash
}
Set-Alias -Name kdebug -Value Start-K8sDebugPod


# ---------------------------------------------------------------------
# 3. 로그 분석 (Logs & Tracking)
# ---------------------------------------------------------------------
function Get-K8sLogs {
  param(
    [string]$AppName = "buddham-api",
    [int]$Tail = 50,
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl logs -l "app=$AppName" -n (Get-TargetNs $Ns) --tail=$Tail
}
Set-Alias -Name klog -Value Get-K8sLogs

function Get-K8sPrevLogs {
  param(
    [string]$AppName = "buddham-api",
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl logs -l "app=$AppName" -n (Get-TargetNs $Ns) --previous
}
Set-Alias -Name klogp -Value Get-K8sPrevLogs

function Watch-K8sLogs {
  param(
    [string]$AppName = "buddham-api",
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl logs -l "app=$AppName" -n (Get-TargetNs $Ns) -f
}
Set-Alias -Name klogf -Value Watch-K8sLogs

function Find-K8sTraceLog {
  param(
    [Parameter(Mandatory = $true)][string]$TraceId,
    [string]$AppName = "buddham-api",
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl logs -l "app=$AppName" -n (Get-TargetNs $Ns) --tail=200 | Select-String $TraceId
}
Set-Alias -Name klogtrace -Value Find-K8sTraceLog

function Find-K8sErrorLogs {
  param(
    [string]$AppName = "buddham-api",
    [int]$Tail = 100,
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl logs -l "app=$AppName" -n (Get-TargetNs $Ns) --tail=$Tail | Select-String -Pattern "fail|error|Exception"
}
Set-Alias -Name klogerr -Value Find-K8sErrorLogs

function Get-K8sPrefixLogs {
  param(
    [string]$AppName = "buddham-api",
    [int]$Tail = 50,
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl logs -l "app=$AppName" -n (Get-TargetNs $Ns) --tail=$Tail --prefix
}
Set-Alias -Name klogpx -Value Get-K8sPrefixLogs


# ---------------------------------------------------------------------
# 4. 전수조사 및 네트워크 테스트 (Network Test)
# ---------------------------------------------------------------------
function Test-K8sOllamaCurl {
  param(
    [string]$TargetUrl = "http://192.168.0.8:11434/api/tags",
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl run debug --image=nicolaka/netshoot --rm -it --restart=Never -n (Get-TargetNs $Ns) -- curl $TargetUrl
}
Set-Alias -Name ktest-ollama -Value Test-K8sOllamaCurl


# ---------------------------------------------------------------------
# 5. 배포 및 스케일 관리 (Deploy & Rollout)
# ---------------------------------------------------------------------
function Apply-K8sYaml {
  param(
    [string]$YamlPath = "k8s/buddham-api.yaml",
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl apply -f $YamlPath -n (Get-TargetNs $Ns)
}
Set-Alias -Name kapply -Value Apply-K8sYaml

function Restart-K8sDeploy {
  param(
    [string]$DeployName = "buddham-api-deploy",
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl rollout restart "deployment/$DeployName" -n (Get-TargetNs $Ns)
}
Set-Alias -Name krestart -Value Restart-K8sDeploy

function Get-K8sRolloutStatus {
  param(
    [string]$DeployName = "buddham-api-deploy",
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl rollout status "deployment/$DeployName" -n (Get-TargetNs $Ns)
}
Set-Alias -Name kstatus -Value Get-K8sRolloutStatus

function Undo-K8sRollout {
  param(
    [string]$DeployName = "buddham-api-deploy",
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl rollout undo "deployment/$DeployName" -n (Get-TargetNs $Ns)
}
Set-Alias -Name kundo -Value Undo-K8sRollout

function Set-K8sScale {
  param(
    [int]$Replicas = 3,
    [string]$DeployName = "buddham-api-deploy",
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl scale "deployment/$DeployName" --replicas=$Replicas -n (Get-TargetNs $Ns)
}
Set-Alias -Name kscale -Value Set-K8sScale

function Get-K8sReplicaSet {
  param([string]$Ns = $global:CURRENT_NS)
  kubectl get replicaset -n (Get-TargetNs $Ns)
}
Set-Alias -Name kgrs -Value Get-K8sReplicaSet


# ---------------------------------------------------------------------
# 6. 시크릿 및 인코딩/디코딩 (Secrets & ConfigMap)
# ---------------------------------------------------------------------
function Get-K8sSecrets {
  param([string]$Ns = $global:CURRENT_NS)
  kubectl get secrets -n (Get-TargetNs $Ns)
}
Set-Alias -Name kgsec -Value Get-K8sSecrets

function Describe-K8sSecret {
  param(
    [string]$SecretName = "buddham-postgres-secret",
    [string]$Ns = $global:CURRENT_NS
  )
  kubectl describe secret $SecretName -n (Get-TargetNs $Ns)
}
Set-Alias -Name kdsec -Value Describe-K8sSecret

# PowerShell 전용 인라인 Base64 디코더 (완벽 매핑)
function Get-K8sSecretValue {
  param(
    [string]$SecretName = "buddham-postgres-secret",
    [string]$Key = "DefaultConnection",
    [string]$Ns = $global:CURRENT_NS
  )
  $targetNs = Get-TargetNs $Ns
  $jsonPath = "{.data.$Key}"
  $rawBase64 = kubectl get secret $SecretName -n $targetNs -o jsonpath=$jsonPath 2>$null

  if ($rawBase64) {
    $decoded = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($rawBase64))
    Write-Host "🔓 Key [$Key] Unlocked:" -ForegroundColor Green
    return $decoded
  }
  else {
    Write-Host "❌ 시크릿 데이터 [$Key] 를 가져올 수 없습니다." -ForegroundColor Red
  }
}
Set-Alias -Name get-ksecret -Value Get-K8sSecretValue


# ---------------------------------------------------------------------
# 7. 인프라 리소스 & 메트릭 감시 (Infrastructure & Top)
# ---------------------------------------------------------------------
function Get-K8sService {
  param([string]$Ns = $global:CURRENT_NS)
  kubectl get svc -n (Get-TargetNs $Ns)
}
Set-Alias -Name kgsvc -Value Get-K8sService

function Get-K8sServiceAll { kubectl get svc -A }
Set-Alias -Name kgsvc-all -Value Get-K8sServiceAll

function Get-K8sNodes { kubectl get nodes -o wide }
Set-Alias -Name kgn -Value Get-K8sNodes

function Get-K8sPvc {
  param([string]$Ns = $global:CURRENT_NS)
  kubectl get pv, pvc -n (Get-TargetNs $Ns)
}
Set-Alias -Name kgpvc -Value Get-K8sPvc

function Get-K8sTopPods {
  param([string]$Ns = $global:CURRENT_NS)
  kubectl top pods -n (Get-TargetNs $Ns)
}
Set-Alias -Name ktop -Value Get-K8sTopPods

function Get-K8sCronJob {
  param([string]$Ns = $global:CURRENT_NS)
  kubectl get cronjob -n (Get-TargetNs $Ns)
}
Set-Alias -Name kgcron -Value Get-K8sCronJob


# ---------------------------------------------------------------------
# 8. 네임스페이스 및 클러스터 컨텍스트 관리 (Cluster & Context)
# ---------------------------------------------------------------------
function Get-K8sNamespaces { kubectl get namespace }
Set-Alias -Name kgns -Value Get-K8sNamespaces

function Get-K8sContexts { kubectl config get-contexts }
Set-Alias -Name kgctx -Value Get-K8sContexts

function Set-K8sContext {
  param([Parameter(Mandatory = $true)][string]$ContextName)
  kubectl config use-context $ContextName
}
Set-Alias -Name kctx -Value Set-K8sContext


# ---------------------------------------------------------------------
# 9. 총제독 전용 대시보드 도움말 (Help Menu)
# ---------------------------------------------------------------------
function Show-FleetDashboard {
  Write-Host "`n=======================================================" -ForegroundColor Cyan
  Write-Host " ⚓ 백우(Baek-Woo) 총제독 통합 함대 지휘 쉘 (T-1000)" -ForegroundColor Yellow
  Write-Host " 🎯 현재 타겟 네임스페이스: [$global:CURRENT_NS]" -ForegroundColor Green
  Write-Host "=======================================================" -ForegroundColor Cyan
  Write-Host " [컨텍스트 스위칭]" -ForegroundColor DarkYellow
  Write-Host "  kns <name>        : 네임스페이스 즉시 전환 (buddham, writer, vivakr ...)"
  Write-Host "  kns-get           : 현재 타겟 네임스페이스 확인"
  Write-Host "`n [주요 단축키 모음]" -ForegroundColor DarkYellow
  Write-Host "  kgp / kgpr / kgpw : 파드 목록 / Running 파드 / Wide 정보"
  Write-Host "  kgpwch            : 실시간 파드 감시 (PowerShell Loop)"
  Write-Host "  klog / klogerr    : 최근 로그 / 에러 로그 필터링 (Select-String)"
  Write-Host "  kexec / kdebug    : 파드 쉘 접속 / 디버그 파드 즉시 실행"
  Write-Host "  get-ksecret       : Base64 자동 디코딩 시크릿 값 추출"
  Write-Host "  ktop / kgpvc      : CPU·메모리 사용량 / 볼륨 상태 점검"
  Write-Host "  krestart / kscale : 배포 재시작 / 레플리카 파드 수 조정"
  Write-Host "-------------------------------------------------------`n"
}
Set-Alias -Name fleet -Value Show-FleetDashboard
Set-Alias -Name t1000 -Value Show-FleetDashboard
